extends Queue

## A Queue that is sorted in order of a user establsihed priotity
class_name PriorityQueue

## A callable (Lambda function) that establishes how the data objects will be sorted. 
## _comparator should compare two objects to be sorted in the Queue and return 1 if the first object is greater, 0 if equal, and -1 if less than.
var _comparator: Callable #: set = _private_setter, get = _private_getter # (Maybe) Create a new class called Comparator and change this from callable to comparator. See Java Docs for details

## Constructs a Queue based on "data". If no data is provided, constructs an empty Queue.
## @param data: existing data with which the Queue should be constructed.
## @param max_size: The maximum number of objects to be stored in the Queue. If set to 0 or less, no limit will be imposed.
## @param prioritize_additions: If true the front of the Queue will be index 0 and removals will be slower, else the back of the array will be the front of the Queue and additions will be slower.
## @param comparator: A callable (Lambda function) that establishes how the data objects will be sorted. _comparator should compare two objects to be sorted in the Queue and return 1 if the first object is greater, 0 if equal, and -1 if less than.
func _init(data=null, comparator=null): # max_size=-1, comparator=null):
	super(data, false) # max_size, false) # prioritize_additions is set to false by default to make the insert algorithm simpler (the head of the Queue will always be at the right side) and to make removal quicker (since additions will unpredictable but removal is always from the end)
	if comparator != null:
		_comparator = comparator
	else:
		pass
		_comparator = default_comparator
	

## Determines where the item belongs in the Queue and inserts it.
## @param item: the item being inserted into the PriorityQueue.
## @return True if the item is succesfully inserted, else false
func offer(item) -> bool:
	# The front of every PriorityQueue is considered to be the right side (i.e. highest priority goes to the right side of the queue)
	if _data.is_empty(): 
		_data.push_front(item)
		return true
		
	return binary_search_insert(item)
	
## Determines where the item belongs in the Queue and inserts it.
## @param item: the item being inserted into the PriorityQueue.
## @return True if the item is succesfully inserted, else false
func binary_search_insert(item) -> bool:
	var left := 0
	var right : int = _data.size() - 1
	
	while left <= right:
		#var mid : int = left + (right - 1) / 2
		var mid: int = (left + right) / 2
		
		var comparison : int = _comparator.call(item, _data[mid]) # if the item is greater than object at mid (returns 1) it must be inserted somewhere to the right of mid, and left if it is smaller (returns -1).
		match comparison:
			0:
				#if mid - 1 >= 0:
					#_data.insert(mid - 1, item)
				#else: _data.insert(mid, item)
				_data.insert(mid, item)
				return true
			
			1: 
				if mid + 1 >= _data.size() or _comparator.call(item, _data[mid + 1]) <= 0:
					_data.insert(mid + 1, item)
					return true
				else:
					left = mid + 1
				
			-1: 
				if mid <= 0 or _comparator.call(item, _data[mid - 1]) > 0:
					#if mid == 0:
						#_data.insert(mid, item)
					#else:
						#_data.insert(mid - 1, item)
					_data.insert(mid, item)
					return true
				#elif _comparator.call(item, _data[mid - 1]) == 0: #TEST to make sure that the new element ends up inserted properly to the left in the event it is equal to the item at index mid-1. i.e. insert one into [1,1,1,1,1,1,2,2,3] (obciously do so in a way that makes it obvious where the new value is)
				else:
					right = mid - 1
				
	return false

## Private Method
## Determines if the item can be inserted into the Priority Queue based on max_size and inserts it if able
## @param item: The item to be inserted
## @param index: The index at which to insert the item
## @return: true if the item is succesfully inserted, else false.
## DO NOT USE! This method was removed after determining that the PriorityQueue should not track a max size. If a user wishes top restrict Priority Queue size it should be done by: "if PriorityQueue.size() < x: offer(y)
func _insert(_item, _index) -> bool:
	return false

## Compares two items to determine which is greater/has higher priority
## @param item1: the first item being compared
## @param item2: the second item being compared
## @return -1 if item1 < item2, 0 if they are equal, and 1 if item1 > item2. Returns -1 if failed
func default_comparator(item1: Object, item2: Object) -> int:
	if item1.has_method("compare_to"):
		return item1.compare_to(item2)
	return -1
	
	#if item1 > item2:
		#return 1
	#if item1 < item2:
		#return -1
	#if item1 == item2:
		#return 0




#func _private_setter(new):
	#push_warning("You are attempting to access a private variable which cannot be accessed externally")
#
#func _private_getter():
	#push_warning("You are attempting to access a private variable which cannot be accessed externally")

