extends Resource

##
class_name LinkedList # TODO Implement all the same methods as a Godot Array has, that way they can be used interchangably without changing method calls (at least as close as possible)

var _head : ListNode
var _tail : ListNode
var _size : int = 0

func _init(data=null):
	if data != null:
		add_all(data)

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
	
	#var temp: ListNode = _head
	#for i in index - 1:
		#if temp.has_next():
			#temp = temp.next
		#else: 
			#push_error("Index ", index, " out of range for list of size ", _size)
			#return ERR_PARAMETER_RANGE_ERROR
	
	var temp = __get_node(index - 1)
	if temp == null:
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
		#_tail
		_tail.next = null
		_size -= 1
		return removed.data
	
	#var temp: ListNode = _head
	#for i in index - 1:
		#if temp.has_next():
			#temp = temp.next
		#else: 
			#push_error("Index ", index, " out of range for list of size ", _size)
			#return ERR_PARAMETER_RANGE_ERROR
	
	var temp = __get_node(index - 1)
	if temp == null:
		push_error("Index ", index, " out of range for list of size ", _size)
		return ERR_PARAMETER_RANGE_ERROR
	
	removed = temp.next
	temp.next = temp.next.next
	temp.next.prev = temp
	_size -= 1
	
	return removed.data

##PRIVATE METHOD! NOT FOR EXTERNAL USE!
##Retrieves the node at index instead of the node data
##Index must be a positive integer less than _size
func __get_node(index: int) -> ListNode:
	if is_empty():
		push_error("Cannot retrieve an element from an empty list")
		return null
	
	if index >= _size or index < 0:
		push_error("Index ", index, " out of range for list of size ", _size)
		return null
	
	var traverse_forward: bool = index < (_size / 2)
	var temp: ListNode
	
	if traverse_forward:
		temp = _head
		for i in index:
			if temp.has_next():
				temp = temp.next
			else: 
				push_error("Index ", index, " out of range for list of size ", _size)
				return null
	
	else:
		temp = _tail
		for i in (_size - index) - 1:
			if temp.has_prev():
				temp = temp.prev
			else:
				push_error("Index ", index, " out of range for list of size ", _size)
				return null
	
	return temp

###PRIVATE METHOD! NOT FOR EXTERNAL USE!
###Retrieves the node at index instead of the node data
#func __get_node(index: int) -> ListNode:
	#var position = index
	#if is_empty():
		#push_error("Cannot retrieve an element from an empty list")
		#return null
	#
	#if index >= _size: # or index < 0:
		#push_error("Index ", index, " out of range for list of size ", _size)
		#return null
	#
	#if index < 0:
		#if abs(index) > _size:
			#push_error("Index ", index, " out of range for list of size ", _size)
			#return null
		#position = _size + index
	#
	#var temp = _head
	#for i in position:
		#temp = temp.next
	#
	#return temp

##Inserts a new element at a given position in the list. The position must be valid, or at the end of the list (pos == size()). Returns OK on success, or one of the other Error values if the operation failed.
##Note: This method acts in-place and doesn't return a modified list.
##Note: On large lists, this method will be slower if the inserted element is close to the end of the list (index 0). This is because all the list must be traversed to insert the new element.
func insert(position: int, value: Variant) -> Error:
	return __add(position, value)

##Inserts all of the elements in the specified collection into this list, starting at the specified position.
##If no position is specified or the position is negative, the collection will be appended to the end
##'Collection must be of type Array or LinkedList
##Returns Error code OK if successful, else the appropriate error code
func add_all(collection, position:=-1) -> Error:
	var additions: LinkedList #To contain the elements that will be added to this list
	
	if collection is Array:
		additions = LinkedList.array_to_linked_list(collection)
	
	elif collection is LinkedList:
		additions = collection
	
	else:
		push_error("Error: parameter \'collection\' is of type ", type_string(typeof(collection)), ". Must be of type Array or LinkedList")
		return ERR_INVALID_PARAMETER
		
	if additions.is_empty():
		return OK
	
	var index: int = position if position <= _size and position >= 0 else _size
	for i in additions.iterator():
		insert(index, i) #additions.get_item(i))
		index += 1
	return OK

##Returns the first element of the list. Prints an error and returns null if the list is empty.
func front() -> Variant:
	if is_empty():
		return null
	return get_item(0)

##Returns the last element of the list. Prints an error and returns null if the list is empty.
func back() -> Variant:
	if is_empty():
		return null
	return get_item(_size - 1)
	
##Appends the specified element to the end of this list.
func append(value: Variant) -> int:
	return push_back(value)
	
##Inserts the specified element at the beginning of this list.
func push_front(value: Variant) -> int:
	return insert(0, value)
	
##Appends the specified element to the end of this list.
func push_back(value: Variant) -> int:
	if is_empty():
		return insert(0, value)
	return insert(_size, value)

##Removes and returns the first element of the list. 
##Returns null if the list is empty, without printing an error message.
func pop_front() -> Variant:
	if is_empty():
		return null
	return pop_at(0)

##Removes and returns the last element of the list. 
##Returns null if the list is empty, without printing an error message.
func pop_back() -> Variant:
	if is_empty():
		return null
	return pop_at(_size - 1)

	
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
##Casts all values as Strings before equality comparison in order to compare unalike types
func has(value: Variant) -> bool:
	var temp = _head
	while temp != null:
		if str(temp.data) == str(value):
			return true
		temp = temp.next
			
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
	
	#var temp = _head
	#for i in position:
		#temp = temp.next
	#
	#return temp.data
	
	return __get_node(position).data
	
#func _get(property): #FIXME Either find a way to override [] notation to accept an int or fix the lines in priority queue that use [] notation
	#if property.is_valid_int():
		#return get_item(property.to_int())
	#return super.get(property)
	
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
##Casts all values as Strings before equality comparison in order to compare unalike types
func last_index_of(value: Variant) -> int:
	var temp = _tail
	
	for i in range(_size - 1, -1, -1):
		if str(temp.data) == str(value):
			return i
		temp = temp.prev
	
	return -1
	
##Returns the number of times an element is in the list.
##Casts all values as Strings before equality comparison in order to compare unalike types
func count(value: Variant) -> int:
	var num_occurence := 0
	
	var temp = _head
	while temp != null:
		if str(temp.data) == str(value):
			num_occurence += 1
		temp = temp.next
	
	return num_occurence
	
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
##Casts all values as Strings before equality comparison in order to compare unalike types
##Reuturns true if the item is found and deleted. Returns false if the item is not present in the list
func remove_first_occurence(value: Variant) -> bool:
	var temp = _head
	for i in _size:
		if str(temp.data) == str(value):
			var _anti_warning_var = pop_at(i)
			return true
		temp = temp.next
		
	return false
	
func remove_last_occurence(value: Variant) -> bool:
	var temp = _tail
	
	for i in range(_size - 1, -1, -1):
		if str(temp.data) == str(value):
			var _anti_warning_var = pop_at(i)
			return true
		temp = temp.prev
		
	return false
	
##Replaces the element at the specified position in this list with the specified element.
##Returns the replaced element or null if setting an empty index.
func set_index(index: int, value: Variant) -> Variant:
	if index > _size or index < 0:
		push_error("Index ", index, " out of range for list of size ", _size)
		return ERR_PARAMETER_RANGE_ERROR
		
	var replaced = null
	if not is_empty() and index < _size:
		replaced = pop_at(index)
		
	var insert_report = insert(index, value)
	if insert_report == OK:
		return replaced
	
	return insert_report
	
##Returns the number of elements in this list.
func size() -> int:
	return _size
	
##Returns an array containing all of the elements in this list in proper sequence (from first to last element).
func to_array() -> Array:
	var list_2_array = []
	
	var temp = _head
	while temp != null:
		list_2_array.append(temp.data)
		temp = temp.next
	
	return list_2_array

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

##Creates and returns an iterator for the current List
##Due to retrieving the iterator via method call, the List can be nested in for loops multiple times
##Parameters start_index, stop_index, and increment function similarly to the "range()" function and will determine where the iterator starts, stops and by how much it increases each pass
##start_index is inclusive, stop index is exclusive
func iterator(start_index:=0, stop_index:=_size, increment:=1) -> LinkedListIterator:
	#if is_empty() or start_index < 0 or stop_index < 0 or start_index >= _size or stop_index > _size:
		#push_error("start_index ", start_index, " or stop_index: ", stop_index, " out of range for list of size ", _size)
		#return LinkedListIterator.empty_iterator()
		#
	#if increment < 0 and stop_index == _size: #This catches the case where someone wants to iterate the list in reverse, but starts at LinkedList.size(), which is out of range for the list
		#push_error("start_index ", start_index, "or stop_index: ", stop_index, " out of range for list of size ", _size)
		#return LinkedListIterator.empty_iterator()
	#
	#var end_iter
	#if (stop_index == _size and increment >= 0) or (stop_index < 0 and increment < 0):
		#end_iter = null 
	##elif stop_index == 0 and increment < 0:
		##end_iter = null
	#else:
		#end_iter = __get_node(stop_index) #If stop_index is size (assuming forward traversal) that means the user wants to traverse to the end of the list inclusively, therefore the iterator should be told to stop when it reaches null
	var end_iter: ListNode
	if increment >= 0:
			end_iter = null if stop_index >= _size else __get_node(stop_index)
	else:
		end_iter = null if stop_index < 0 else __get_node(stop_index)
	return LinkedListIterator.new(__get_node(start_index), end_iter, increment)

##Compares if the elements in the list are equal to the elements in 'to' and returns true if so
func equals(to: LinkedList) -> bool:
	if size() != to.size():
		return false
	for i in size():
		if get_item(i) != to.get_item(i):
			return false
	
	return true
	
static func array_to_linked_list(array: Array) -> LinkedList:
	var new_list = LinkedList.new()
	for i in array:
		new_list.append(i)
		
	return new_list

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
		if data is String:
			return  "\"" + str(data) + "\""
		return str(data)
		
	func metadata():
		return str("[Data: ", data, " Prev: ", prev, " Next: ", next, "]")
		
class LinkedListIterator:
	##The current node in the iterator
	var _iter_current: ListNode
	##The head of the list/starting point for the iterator
	var _head: ListNode
	##The stopping point for the iterator (exclusive)
	var _tail: ListNode
	##The amount by which the iterator will increment each pass
	var _increment: int
	
	func _init(head: ListNode, tail: ListNode, increment):
		_head = head
		_tail = tail
		_increment = increment if increment != 0 else 1
	
	##@OVERRIDE
	func _iter_init(_arg):
		_iter_current = _head
		return iter_should_continue()

	##@OVERRIDE
	func _iter_next(_arg):
		if _increment < 0:
			for i in abs(_increment):
				if _iter_current != null:
					_iter_current = _iter_current.prev
		
		else:
			for i in _increment:
				if _iter_current != null:
					_iter_current = _iter_current.next
				
		return iter_should_continue()

	##@OVERRIDE	
	func _iter_get(_arg):
		return _iter_current.data
	
	##Returns true if the iterator has not finished iterating, false if it has.
	func iter_should_continue() -> bool:
		if _iter_current == null:
			return false

		return _iter_current != _tail
		
	static func empty_iterator() -> LinkedListIterator:
		var empty_node = ListNode.new()
		var empty_iter = LinkedListIterator.new(empty_node, empty_node, 1)
		empty_iter._iter_current = null
		return empty_iter
		
	func _to_string():
		return str("Start: ", _head, ", End: ", _tail, ", Increment: ", _increment, ", Current: ", _iter_current)
