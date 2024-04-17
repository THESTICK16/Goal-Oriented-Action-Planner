extends Resource

class_name LinkedList # TODO Implement all the same methods as a Godot Array has, that way they can be used interchangably without changing method calls (at least as close as possible)

var _head : ListNode
var _tail : ListNode #TODO Implement this into the __add and __remove methods to make sure the tail is tracked properly
var _size : int = 0

func _init(data=null):
	if data != null:
		for i in data:
			pass #TODO Create a new list node one by one and add to the list (i.e. just call "add(i)"

##PRIVATE METHOD! NOT FOR EXTERNAL USE!
##Inserts value at the specified index in the list.
## Returns OK if succesful, else returns an appropriate error code
func __add(index: int, value: Variant) -> Error:
	if index < 0 or index > _size:
		push_error("Index ", index, " out of range for list of size ", _size)
		return ERR_PARAMETER_RANGE_ERROR
	
	if _head == null:
		if index == 0:
			_head = ListNode.new(value)
			_tail = _head
			_size += 1
			return OK
		else: 
			push_error("Index ", index, " out of range for list of size ", _size)
			return ERR_PARAMETER_RANGE_ERROR
			
	if index == 0:
		_head = ListNode.new(value, null, _head)
		if _head.next != null:
			_head.next.prev = _head
		_size += 1
		return OK
		
	#if index == size(): #FIXME IF want to make inserting at end of list instantaneous then implement this code properly. It is currently buggy
		#var temp = _tail
		#temp.next = ListNode.new(value, temp, null)
		#_tail = temp.next
		
	var temp: ListNode = _head
	for i in index - 1:
		if temp.has_next():
			temp = temp.next
		else: 
			push_error("Index ", index, " out of range for list of size ", _size)
			return ERR_PARAMETER_RANGE_ERROR
	
	var offset_node = temp.next #Use this to set prev properly after adding the new node
	temp.next = ListNode.new(value, temp, temp.next)
	if offset_node != null:
		offset_node.prev = temp.next
	_size += 1
	
	while _tail.has_next():
		_tail = _tail.next
		
	return OK

##PRIVATE METHOD! NOT FOR EXTERNAL USE!
##Removes and returns the value at the specified index in the list
## Returns the value at index if succesful, else returns an appropriate error code
func __remove(index: int) -> Variant:
	var removed : Variant
	if _head == null:
		push_error("Cannot remove an element from an empty list")
		return ERR_PARAMETER_RANGE_ERROR
	
	if index > _size - 1 or index < 0:
		push_error("Index ", index, " out of range for list of size ", _size)
		return ERR_PARAMETER_RANGE_ERROR
		
	if index == 0:
		removed = _head
		_head = _head.next
		if _head != null:
			_head.prev = null
		_size -= 1
		return removed.data
		
	if index == _size - 1:
		removed = _tail
		_tail = _tail.prev
		_tail
		_tail.next = null
		_size -= 1
		return removed.data
	
	var temp: ListNode = _head
	for i in index - 1:
		if temp.has_next():
			temp = temp.next
		else: 
			push_error("Index ", index, " out of range for list of size ", _size)
			return ERR_PARAMETER_RANGE_ERROR
	
	removed = temp.next
	temp.next = temp.next.next
	temp.next.prev = temp
	_size -= 1
	
	return removed.data

##Inserts a new element at a given position in the list. The position must be valid, or at the end of the list (pos == size()). Returns OK on success, or one of the other Error values if the operation failed.
##Note: This method acts in-place and doesn't return a modified list.
##Note: On large lists, this method will be slower if the inserted element is close to the end of the list (index 0). This is because all the list must be traversed to insert the new element.
func insert(position: int, value: Variant) -> int:
	return __add(position, value)

##Inserts all of the elements in the specified collection into this list, starting at the specified position.
##If no position is specified, the collection will be appended to the end
func add_all(collection, position:=-1) -> bool:
	return false

##Returns the first element of the list. Prints an error and returns null if the list is empty.
func front() -> Variant:
	return get_item(0)

##Returns the last element of the list. Prints an error and returns null if the list is empty.
func back() -> Variant:
	return get_item(_size - 1)
	
##Appends the specified element to the end of this list.
func append(value: Variant) -> bool:
	return push_back(value)
	
##Inserts the specified element at the beginning of this list.
func push_front(value: Variant) -> bool:
	return false
	
##Appends the specified element to the end of this list.
func push_back(value: Variant) -> bool:
	return false

##Removes and returns the first element of the list. 
##Returns null if the list is empty, without printing an error message.
func pop_front() -> Variant:
	return null

##Removes and returns the last element of the list. 
##Returns null if the list is empty, without printing an error message.
func pop_back() -> Variant:
	return null

	
##Removes all of the elements from this list.
func clear() -> void:
	_head = null
	_tail = null
	_size = 0
	
##Returns true if this list is empty
func is_empty() -> bool:
	if _head == null:
		return true
	
	return false

##Returns true if this list contains the specified element.
func has(value: Variant) -> bool:
	return false

##Returns the element at the specified position in this list.
##If negative, index is considered relative to the end of the list.
func get_item(index: int) -> Variant:
	var position = index
	if is_empty():
		push_error("Cannot retrieve an element from an empty list")
		return ERR_PARAMETER_RANGE_ERROR
	
	if index >= _size: # or index < 0:
		push_error("Index ", index, " out of range for list of size ", _size)
		return ERR_PARAMETER_RANGE_ERROR
	
	if index < 0:
		if abs(index) > _size:
			push_error("Index ", index, " out of range for list of size ", _size)
			return ERR_PARAMETER_RANGE_ERROR
		position = _size + index
	
	var temp = _head
	for i in position:
		temp = temp.next
	
	return temp.data
	
##Returns the index of the first occurrence of the specified element in this list, or -1 if this list does not contain the element.
##Casts all values as Strings before equality comparison in order to compare unalike types
func index_of(value: Variant) -> int:
	var temp = _head
	
	for i in _size:
		if str(temp.data) == str(value):
			return i
		temp = temp.next
		
	return -1
	
##Returns the index of the last occurrence of the specified element in this list, or -1 if this list does not contain the element.
func last_index_of(value: Variant) -> int:
	return -1
	
##Returns the number of times an element is in the array.
func count(value: Variant) -> int:
	return -1
	
##Removes and returns the element of the list at index position. 
##If negative, index is considered relative to the end of the list. 
##Leaves the list untouched and returns an error code if the list is empty or if it's accessed out of bounds. An error message is printed when the list is accessed out of bounds, but not when the list is empty.
func pop_at(index: int) -> Variant:
	if is_empty():
		push_error("Cannot remove an element from an empty list")
		return ERR_PARAMETER_RANGE_ERROR
		
	if index >= _size:
		push_error("Index ", index, " out of range for list of size ", _size)
		return ERR_PARAMETER_RANGE_ERROR
	
	if index < 0:
		if abs(index) > _size:
			push_error("Index ", index, " out of range for list of size ", _size)
			return ERR_PARAMETER_RANGE_ERROR
		return __remove(_size + index)
		
	return __remove(index)
	
##Removes the first occurrence of the specified element in this list (when traversing the list from head to tail).
func remove_first_occurence(item) -> bool:
	return false
	
##Replaces the element at the specified position in this list with the specified element.
func set_index(item, index) -> bool:
	return false
	
##Returns the number of elements in this list.
func size() -> int:
	return _size
	
##Returns an array containing all of the elements in this list in proper sequence (from first to last element).
func to_array() -> Array:
	return []

func _to_string():
	var temp := _head
	
	if temp == null:
		return "[]"
		
	var list_string: String = "["
	while temp.has_next():
		list_string += str(temp) + ", "
		temp = temp.next
		
	list_string += str(temp) + "]"
	
	return list_string
	
func metadata():
	var temp := _head
	
	if temp == null:
		return "[]"
		
	var list_string: String = "["
	while temp.has_next():
		list_string += str(temp.metadata()) + ", "
		temp = temp.next
		
	list_string += str(temp.metadata()) + "]"
	
	return list_string


#TODO Below
#You can create custom iterators in case the default ones don't quite meet your needs by overriding the Variant class's _iter_init, _iter_next, and _iter_get functions in your script. An example implementation of a forward iterator follows:
#
#class ForwardIterator:
	#var start
	#var current
	#var end
	#var increment
#
	#func _init(start, stop, increment):
		#self.start = start
		#self.current = start
		#self.end = stop
		#self.increment = increment
#
	#func should_continue():
		#return (current < end)
#
	#func _iter_init(arg):
		#current = start
		#return should_continue()
#
	#func _iter_next(arg):
		#current += increment
		#return should_continue()
#
	#func _iter_get(arg):
		#return current
#
#And it can be used like any other iterator:
#
#var itr = ForwardIterator.new(0, 6, 2)
#for i in itr:
	#print(i) # Will print 0, 2, and 4.
#
#Make sure to reset the state of the iterator in _iter_init, otherwise nested for-loops that use custom iterators will not work as expected.



class ListNode:
	var data : Variant
	var prev : ListNode = null
	var next : ListNode = null
	
	func _init(data_:Variant=null, prev_:ListNode=null, next_:ListNode=null):
		data = data_
		prev = prev_
		next = next_
	
	func has_next() -> bool:
		return next != null
	
	func has_prev() -> bool:
		return prev != null
		
	func _to_string():
		return str(data)
		
	func metadata():
		return str("[Data: ", data, " Prev: ", prev, " Next: ", next, "]")
