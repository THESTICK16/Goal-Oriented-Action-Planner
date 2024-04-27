extends Resource

## A First-In-First-Out Queue.
class_name Queue

## Used to determine wha type of data structure the queue will use as a base
## QUEUE_TYPE_ARRAY will use an Array and have faster access to any element in the queue, however either insertions or deletions will be slower due to cycling all other elements over.
## QUEUE_TYPE_LINKED_LIST will use a Linked List and have constant insertion/deletion, but will take longer to access elements in the middle of the list due to having to cycle through each element to get there.
## QUEUE_TYPE_LINKED_LIST will be set as the default
#enum QUEUE_TYPE {QUEUE_TYPE_ARRAY, QUEUE_TYPE_LINKED_LIST} #TODO Actually implement this into Queue

## The Array containing the data for the Queue to pull from.
var _data #: set = _private_setter, get = _private_getter
## The maximum number of elements that can be added tp the Queue.
## if _max_size is <=0, size is unlimited. 
var _max_size: int #: set = _private_setter#, get = _private_getter
## Determines wether to make additions faster than removals or vice-versa.
## If true the front of the Queue will be index 0 and removals will be slower, else the back of the array will be the front of the Queue and additions will be slower.
var _prioritize_additions : bool

## Constructs a Queue based on "data". If no data is provided, constructs an empty Queue.
## @param data: existing data with which the Queue should be constructed.
## @param max_size: The maximum number of objects to be stored in the Queue. If set to 0 or less, no limit will be imposed.
## @param prioritize_additions: If true the front of the Queue will be index 0 and removals will be slower, else the back of the array will be the front of the Queue and additions will be slower.
func _init(data=null, max_size:=-1, prioritize_additions:=true): #, queue_type:QUEUE_TYPE=QUEUE_TYPE.QUEUE_TYPE_LINKED_LIST):
	#match queue_type: #FIXME Array cannot take null as a constructor
		#QUEUE_TYPE.QUEUE_TYPE_ARRAY:
			#_data = Array(data)
		#QUEUE_TYPE.QUEUE_TYPE_LINKED_LIST:
			##_data = LinkedList.new(data) #FIXME once linked list has been implemented, uncomment this line and delete the one below
			#_data = Array(data)
	
	if data != null:
		_data = LinkedList.new(Array(data))
	else:
		_data = LinkedList.new() #Array()
		
	if max_size > 0 and max_size < _data.size():
		push_warning("\'max_size\' must be greater than or equal to the initial data's size. \'max_size\' will be set to \'data.size()\'")
		_max_size = _data.size()
	else: 
		_max_size = max_size
		
	self._prioritize_additions = prioritize_additions
	
## Inserts the specified element into this queue if it is possible to do so immediately without violating capacity restrictions.
func offer(item) -> bool:
	if _max_size > 0 and _data.size() >= _max_size:
		return false
		
	if _prioritize_additions: _data.push_back(item)
	else: _data.push_front(item)
	#_data.push_back(item) if prioritize_additions else _data.push_front(item)
	#if prioritize_additions:
		#_data.push_back(item)
	#else: 
		#_data.push_front(item)
	return true
	
## Retrieves and removes the head of this queue, or returns null if this queue is empty.
func poll():
#	if prioritize_additions: return _data.pop_front()
#	else: return _data.pop_back()
	return _data.pop_front() if _prioritize_additions else _data.pop_back() # Checking if empty first is unnecessary as the 'pop' functions will return null with no error

## Inserts the specified element into this queue if it is possible to do so immediately without violating capacity restrictions, returning true upon success and throwing an IllegalStateException if no space is currently available.
#func add(item) -> bool:
#	return false
	
## Retrieves, but does not remove, the head of this queue, or returns null if this queue is empty.
func peek():
	if _data.is_empty(): return null
		
#	if prioritize_additions: return _data.front()
#	else: return _data.back()

#	push_warning("Test to make sure the ternary conditional works for a return statement!!!\nIf it does work, apply this to the other functions as well!")
#	TESTED ABOVE. IT WORKS
	return _data.front() if _prioritize_additions else _data.back()

## Returns true if this queue contains the specified element.
func contains(element) -> bool:
	return _data.has(element)

## Returns the number of elements in this Queue.
func size() -> int:
	return _data.size()

## Returns an array containing all of the elements in this queue.
## This array is a copy and modifying the Array order will not modify the queue order.
## Modifying Individual elements in the array accesed via reference (i.e. objects) will modify those in the queue as well.
func to_array() -> Array:
	#if _data is LinkedList:
	return _data.to_array()
	return _data.duplicate()

## Removes all of the elements from this queue.
func clear() -> void:
	#_data =[]
	_data.clear()

## Returns true if the Queue is at maximum capacity, false if additions can still be made.
func is_full() -> bool:
	return true if (_max_size > 0 and _data.size() >= _max_size) else false
	
func _to_string():
	return str(_data)
	
func _meta_data():
	return ("Data: " + str(_data) + " \nMax Size: " + str(_max_size) + " \nPrioritize Additions: " + str(_prioritize_additions))
	
#func set_prioritize_additions(prioritize_addition: bool): #FIXME Do not allow changes to prioritize_additions as they will create buggy behavior
	#prioritize_additions = prioritize_addition
	
#region Private Setter/Getter. DO NOT USE. As of Godot 4.0 this method no longer works as intended.
#func _private_setter(new):
	#push_warning("You are attempting to access a private variable which cannot be accessed externally")
#
#
#func _private_getter():
#	push_warning("You are attempting to access a private variable which cannot be accessed externally")
#endregion
