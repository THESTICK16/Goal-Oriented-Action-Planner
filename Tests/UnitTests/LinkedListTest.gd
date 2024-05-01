extends UnitTest
class_name LinkedListTest

var ll: LinkedList
var ll2: LinkedList

func run_before_each():
	ll = LinkedList.new()
	ll2 = LinkedList.new()
	
	for i in 10:
		ll2.insert(i,i)
		
func run_after_each():
	test(is_list_cohesive(ll))
	test(is_list_cohesive(ll2))
	
func test_add():
	for i in 10:
		ll.__add(i, i)
		test(ll.size() == i + 1)
		test(ll._tail.data == i)
	
	test(ll.to_string() == "[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]")
	
	ll.__add(5, 'five')
	test(ll.to_string() == "[0, 1, 2, 3, 4, \"five\", 5, 6, 7, 8, 9]")
	ll.__add(7, 100)
	test(ll.to_string() == "[0, 1, 2, 3, 4, \"five\", 5, 100, 6, 7, 8, 9]")

	test(ERR_PARAMETER_RANGE_ERROR == int(ll.__add(ll.size() + 1, "blue")))
	test(ERR_PARAMETER_RANGE_ERROR == int(ll.__add(-1, "blue")))
	test(ERR_PARAMETER_RANGE_ERROR == int(ll.__add(50, "blue")))
	
	ll.__add(ll.size(), "pink")
	test(ll._tail.data == "pink")
	ll.__add(ll.size(), true)
	test(ll._tail.data == true)
	ll.__add(ll.size(), 3.21)
	test(ll._tail.data == 3.21)
	ll.__add(ll.size(), 'a')
	test(ll._tail.data == 'a')
	
	ll.__add(0, 'b')
	test(ll._head.data == 'b')
	ll.__add(0, 'c')
	test(ll._head.data == 'c')
	ll.__add(0, 'd')
	test(ll._head.data == 'd')
	
	test(ll.size() == 19)
	test(is_list_cohesive(ll))

func test_remove():
	test(ERR_PARAMETER_RANGE_ERROR == ll.__remove(0))
	test(ERR_PARAMETER_RANGE_ERROR == ll.__remove(1))
	test(ERR_PARAMETER_RANGE_ERROR == ll.__remove(10))
	
	for i in 10:
		ll.__add(i, i)
	
	test(0 == ll.__remove(0))
	test(ll._head.data == 1)
	test(ll.size() == 9)
	test(9 == ll.__remove(ll.size() - 1))
	test(ll._tail.data == 8)
	test(ll.size() == 8)
	
	test(4 == ll.__remove(3))
	test(8 == ll.__remove(6))
	
	var size: int = ll.size()
	test(ERR_PARAMETER_RANGE_ERROR == ll.__remove(-1))
	test(ll.size() == size)
	test(ERR_PARAMETER_RANGE_ERROR == ll.__remove(11))
	test(ll.size() == size)
	test(ERR_PARAMETER_RANGE_ERROR == ll.__remove(ll.size()))
	test(ll.size() == size)
	test(ERR_PARAMETER_RANGE_ERROR == ll.__remove(100))
	test(ll.size() == size)
	
	while ll._size > 0:
		var _removed = ll.__remove(ll.size() - 1)
		#print("Removed: ", removed, " List:", ll.metadata())
		test(is_list_cohesive(ll))
		#test(OK == ll.__remove(ll.size() - 1))
		#print(ll)
		#print(ll.__remove(ll.size() - 1))
	
	test(ll.size() == 0)
	
func test_get_node():
	for i in range(10, (randi() % 100)):
		ll2.append(i)
	for i in ll2.size():
		test((ll2.__get_node(i).data == i))
		#print(ll2.__get_node(i), " ", i)
	
func test_insert():
	for i in 10:
		ll.insert(i, i)
		test(ll.size() == i + 1)
		test(ll._tail.data == i)
	
	test(ll.to_string() == "[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]")
	
	ll.insert(5, 'five')
	test(ll.to_string() == "[0, 1, 2, 3, 4, \"five\", 5, 6, 7, 8, 9]")
	ll.insert(7, 100)
	test(ll.to_string() == "[0, 1, 2, 3, 4, \"five\", 5, 100, 6, 7, 8, 9]")

	test(ERR_PARAMETER_RANGE_ERROR == int(ll.insert(ll.size() + 1, "blue")))
	test(ERR_PARAMETER_RANGE_ERROR == int(ll.insert(-1, "blue")))
	test(ERR_PARAMETER_RANGE_ERROR == int(ll.insert(50, "blue")))
	
	ll.insert(ll.size(), "pink")
	test(ll._tail.data == "pink")
	ll.insert(ll.size(), true)
	test(ll._tail.data == true)
	ll.insert(ll.size(), 3.21)
	test(ll._tail.data == 3.21)
	ll.insert(ll.size(), 'a')
	test(ll._tail.data == 'a')
	
	ll.insert(0, 'b')
	test(ll._head.data == 'b')
	ll.insert(0, 'c')
	test(ll._head.data == 'c')
	ll.insert(0, 'd')
	test(ll._head.data == 'd')
	
	test(ll.size() == 19)
	test(is_list_cohesive(ll))
	
func test_add_all():
	for i in range(10, 20):
		ll.append(i)
	test(ll.add_all(ll2) == OK)
	test(ll.size() == 20)
	test(ll.get_item(0) == 10)
	test(ll.get_item(10) == 0)
	test(ll.get_item(19) == 9)
	test(is_list_cohesive(ll))
	
	ll.clear()
	for i in range(10, 20):
		ll.append(i)
	test(ll.add_all(ll2, 5) == OK)
	test(ll.size() == 20)
	test(ll.get_item(0) == 10)
	test(ll.get_item(4) == 14)
	test(ll.get_item(5) == 0)
	test(ll.get_item(14) == 9)
	test(ll.get_item(19) == 19)
	test(is_list_cohesive(ll))
	
	test(ERR_INVALID_PARAMETER == ll.add_all(true))
	test(ERR_INVALID_PARAMETER == ll.add_all(Resource.new()))
	test(ERR_INVALID_PARAMETER == ll.add_all(5))
	test(ERR_INVALID_PARAMETER == ll.add_all("true"))

func test_front():
	test(ll.front() == null)
	for i in 10:
		test(ll2.front() == i)
		ll2.pop_at(0)
	
func test_back():
	test(ll.back() == null)
	for i in range(9, -1, -1):
		test(ll2.back() == i)
		ll2.pop_at(ll2.size() - 1)

func test_append():
	for i in 10:
		test(ll.append(i) == OK)
	for i in 10:
		test(ll.get_item(i) == i)
	
func test_push_front():
	test(ll.push_front("Cloud") == OK)
	test(ll.front() == "Cloud")
	
	for i in range(10, 20):
		test(ll2.push_front(i) == OK)
		test(ll2.front() == i)
	
func test_push_back():
	test(ll.push_back("Cloud") == OK)
	test(ll.back() == "Cloud")
	
	
	for i in range(10, 20):
		test(ll2.push_back(i) == OK)
		test(ll2.back() == i)

func test_pop_front():
	test(ll.pop_front() == null)
	for i in ll2.size():
		test(ll2.pop_front() == i)
	test(ll2.is_empty())

func test_pop_back():
	test(ll.pop_back() == null)
	for i in range(ll2.size() - 1, -1, -1):
		test(ll2.pop_back() == i)

func test_clear():
	test( not ll2.is_empty())
	ll2.clear()
	test(ll2.is_empty())
	test(ll2.size() == 0)
	test(ll2._head == null)
	test(ll2._tail == null)
	test(ll2.front() == null)
	test(ll2.back() == null)
	
func test_is_empty():
	test(ll.is_empty())
	test(not ll2.is_empty())
	
	var ll3 = LinkedList.new()
	test(ll3.is_empty())
	ll3.insert(0, 0)
	test(not ll3.is_empty())
	ll3.__remove(0)
	test(ll3.is_empty())
	
	test(is_list_cohesive(ll3))
	
func test_has():
	for i in ll2.size() - 1:
		test(ll2.has(i))
		
	test(not ll2.has(11))
	test(not ll2.has(-1))
	test(not ll2.has(-10))
	test(not ll2.has(50000000))
	test(not ll.has(0))
	
	ll.append("Aerith")
	ll.append("Barret")
	ll.append("Tifa")
	test(ll.has("Aerith"))
	test(ll.has("Barret"))
	test(ll.has("Tifa"))

func test_get_item():
	for i in 10:
		test(i == ll2.get_item(i))
	
	test(ll2.get_item(ll2.size()) == ERR_PARAMETER_RANGE_ERROR)
	test(ll2.get_item(-30) == ERR_PARAMETER_RANGE_ERROR)
	test(ll2.get_item(50) == ERR_PARAMETER_RANGE_ERROR)
	
	test(ll2.get_item(0) == 0)
	test(ll2.get_item(9) == 9)
	test(ll2.get_item(3) == 3)
	test(ll2.get_item(-1) == 9)
	test(ll2.get_item(0 - ll2.size()) == 0)
	test(ll2.get_item(-5) == 5)
	
func test_index_of():
	test(ll2.index_of(9) == 9)
	test(ll2.index_of(0) == 0)
	test(ll2.index_of(5) == 5)
	test(ll2.index_of(7) == 7)
	
	ll.insert(0, "fall")
	ll.insert(1, "autumn")
	ll.insert(2, true)
	ll.insert(3, 3.14159)
	test(0 == ll.index_of("fall"))
	test(1 == ll.index_of("autumn"))
	test(2 == ll.index_of(true))
	test(3 == ll.index_of(3.14159))
	
	for i in 10:
		ll2.append(i)
		
	test(ll2.index_of(9) == 9)
	test(ll2.index_of(0) == 0)
	test(ll2.index_of(5) == 5)
	test(ll2.index_of(7) == 7)
	
	test(ll2.index_of(9) != 19)
	test(ll2.index_of(0) != 10)
	test(ll2.index_of(5) != 15)
	test(ll2.index_of(7) != 17)
	
func test_last_index_of():
	test(ll2.last_index_of(9) == 9)
	test(ll2.last_index_of(0) == 0)
	test(ll2.last_index_of(5) == 5)
	test(ll2.last_index_of(7) == 7)
	
	ll.insert(0, "fall")
	ll.insert(1, "autumn")
	ll.insert(2, true)
	ll.insert(3, 3.14159)
	test(0 == ll.last_index_of("fall"))
	test(1 == ll.last_index_of("autumn"))
	test(2 == ll.last_index_of(true))
	test(3 == ll.last_index_of(3.14159))
	
	for i in 10:
		ll2.append(i)
	
	test(ll2.last_index_of(9) == 19)
	test(ll2.last_index_of(0) == 10)
	test(ll2.last_index_of(5) == 15)
	test(ll2.last_index_of(7) == 17)
	
	test(ll2.last_index_of(9) != 9)
	test(ll2.last_index_of(0) != 0)
	test(ll2.last_index_of(5) != 5)
	test(ll2.last_index_of(7) != 7)
	
func test_count():
	test(ll2.count(0) == 1)
	test(ll2.count(9) == 1)
	test(ll2.count(5) == 1)
	test(ll2.count(-1) == 0)
	test(ll2.count(10) == 0)
	test(ll2.count(13243523) == 0)
	
	for i in 10:
		ll2.append(i)
		ll2.append("Red XIII")
		ll.append("Yuffie")
		
	test(ll2.count(0) == 2)
	test(ll2.count(9) == 2)
	test(ll2.count(5) == 2)
	test(ll2.count("Red XIII") == 10)
	test(ll.count("Yuffie") == 10)
	
	ll2.pop_at(0)
	test(ll2.count(0) == 1)
	

func test_pop_at():
	test(ERR_PARAMETER_RANGE_ERROR == ll.pop_at(0))
	test(ERR_PARAMETER_RANGE_ERROR == ll.pop_at(1))
	test(ERR_PARAMETER_RANGE_ERROR == ll.pop_at(10))
	
	for i in 10:
		ll.__add(i, i)
	
	test(0 == ll.pop_at(0))
	test(ll._head.data == 1)
	test(ll.size() == 9)
	test(9 == ll.pop_at(ll.size() - 1))
	test(ll._tail.data == 8)
	test(ll.size() == 8)
	
	test(4 == ll.pop_at(3))
	test(8 == ll.pop_at(6))
	
	var size: int = ll.size()
	test(ERR_PARAMETER_RANGE_ERROR == ll.pop_at(11))
	test(ll.size() == size)
	test(ERR_PARAMETER_RANGE_ERROR == ll.pop_at(ll.size()))
	test(ll.size() == size)
	test(ERR_PARAMETER_RANGE_ERROR == ll.pop_at(100))
	test(ll.size() == size)
	
	while ll._size > 0:
		var _removed = ll.pop_at(ll.size() - 1)
		#print("Removed: ", removed, " List:", ll.metadata())
		test(is_list_cohesive(ll))
		#test(OK == ll.__remove(ll.size() - 1))
		#print(ll)
		#print(ll.__remove(ll.size() - 1))
	
	test(ll.size() == 0)
	
	#print(ll2)
	#print(ll2.pop_at(-1))
	#print(ll2.pop_at(0 - (ll2.size() - 1)))
	test(9 == ll2.pop_at(-1))
	test(0 == ll2.pop_at(0 - ll2.size()))
	test(4 == ll2.pop_at(-5))
	
func test_remove_first_occurence():
	for i in 10:
		ll2.append(i)
	
	test(not ll2.remove_first_occurence("Cait Sith"))
	ll2.append("Cait Sith")
	test(ll2.has("Cait Sith"))
	test(ll2.remove_first_occurence("Cait Sith"))
	test(not ll2.has("Cait Sith"))
	
	test(ll2.remove_first_occurence(0))
	test(ll2.has(0))
	test(ll2.count(0) == 1)
	test(ll2.front() != 0)
	
	test(ll2.remove_first_occurence(9))
	test(ll2.has(9))
	test(ll2.count(9) == 1)
	test(ll2.back() == 9)
	test(ll2.remove_first_occurence(5))
	
func test_remove_last_occurence():
	for i in 10:
		ll2.append(i)
	
	test(not ll2.remove_last_occurence("Cait Sith"))
	ll2.append("Cait Sith")
	test(ll2.has("Cait Sith"))
	test(ll2.remove_last_occurence("Cait Sith"))
	test(not ll2.has("Cait Sith"))
	
	test(ll2.remove_last_occurence(0))
	test(ll2.has(0))
	test(ll2.count(0) == 1)
	test(ll2.front() == 0)
	
	test(ll2.remove_last_occurence(9))
	test(ll2.has(9))
	test(ll2.count(9) == 1)
	test(ll2.back() != 9)
	test(ll2.remove_last_occurence(5))
	
func test_set_index():
	test(ll2.set_index(5, 20) == 5)
	test(ll2.get_item(5) == 20)
	test(ll2.size() == 10)
	test(ll2.get_item(4) == 4)
	test(ll2.get_item(6) == 6)
	test(not ll2.has(5))
	
	test(ll2.set_index(0, "Apple") == 0)
	test(ll2.get_item(0) == "Apple")
	test(ll2.size() == 10)
	test(ll2.get_item(1) == 1)
	test(ll2._head.data == "Apple")
	test(not ll2.has(0))
	
	test(ll2.set_index(9, 3.214) == 9)
	test(ll2.get_item(9) == 3.214)
	test(ll2.size() == 10)
	test(ll2.get_item(8) == 8)
	test(ll2._tail.data == 3.214)
	test(not ll2.has(9))
	
	test(ll2.set_index(10, true) == null)
	test(ll2.get_item(10) == true)
	test(ll2.size() == 11)
	test(ll2.get_item(9) == 3.214)
	test(ll2._tail.data == true)
	
	test(ll.set_index(12, false) == ERR_PARAMETER_RANGE_ERROR)
	test(ll.set_index(-1, false) == ERR_PARAMETER_RANGE_ERROR)
	test(ll.set_index(1, false) == ERR_PARAMETER_RANGE_ERROR)
	
	test(ll.set_index(0, false) == null)
	test(ll.size() == 1)
	test(ll._head.data == false)
	test(ll._tail.data == false)
	
func test_to_array():
	var ll2_array_demo = [0,1,2,3,4,5,6,7,8,9]
	var ll2_array = ll2.to_array()
	for i in 10:
		test(ll2_array[i] == ll2_array_demo[i])

func test_iterator():
	var target := 0 #The number that the current i should be set to
	for i in ll2.iterator():
		test(i == target)
		target += 1
		
	var outer := [] #The outer loop array to catch the outer loop's iterator
	var inner := [] #The inner loop array to catch the inner loop's iterator
	var o_target := 0 #The number that the current i should be set to
	var i_target := 0 #The number that the current j should be set to
	for i in ll2.iterator():
		test(i == o_target)
		o_target += 1
		i_target = 0
		outer.append(i)
		for j in ll2.iterator():
			test(j == i_target)
			i_target += 1
			inner.append(j)
		#print("Outer iteration ", i)
	#print("Outer: ", outer, "\nInner: ", inner)
	
	for i in ll2.iterator(3, 7):
		test(i >= 3 and i < 7)
	
	for i in ll2.iterator(0, ll2.size(), 2):
		test(i % 2 == 0)
	
	target = 9 #The number that the current i should be set to
	for i in ll2.iterator(ll2.size() - 1, -1, -1):
		test(i == target)
		target -= 1
	test(target == -1) #Ensures that the full list has been traversed all the way back to _head
		
	test(ll.iterator()._iter_current == null)
	test(ll2.iterator(-1, ll2.size())._iter_current == null)
	test(ll2.iterator(0, ll2.size() + 1)._iter_current == null)
	test(ll2.iterator(50, ll2.size())._iter_current == null)
	test(ll2.iterator(0, -2)._iter_current == null)
	
	for i in ll2.iterator(0, ll2.size(), 5):
		test(i == 0 or i == 5)
	target = 3 #The number of times the following iterator should loop
	for i in ll2.iterator(ll2.size() - 1, -1, -3):
		test(i % 3 == 0)
		target -= 1
	test(target == -1)
	for i in ll2.iterator(ll2.size() - 3, 3, -1):
		test(i <= 7 and i > 3)
		
	for i in LinkedList.LinkedListIterator.empty_iterator():
		test(false)
		
func test_array_to_linked_list():
	var array := [0,1,2,3,4,5,6,7,8,9]
	var list_from_array = LinkedList.array_to_linked_list(array)
	test(list_from_array is LinkedList)
	test(list_from_array.get_item(0) == 0)
	test(list_from_array.get_item(9) == 9)
	test(is_list_cohesive(list_from_array))
	test(ll2.equals(list_from_array))

func test_equals():
	test(not ll.equals(ll2))
	for i in 10:
		ll.append(i)
	
	test(ll.equals(ll2))
	test(ll2.equals(ll))
	
	ll.append("Hojo")
	test(not ll.equals(ll2))

func is_list_cohesive(l: LinkedList) -> bool:
	var forward_list := []
	var backward_list := []
	
	var temp = l._head
	if temp == null:
		return true
	while  temp.has_next():
		forward_list.append(temp.data)
		temp = temp.next
	forward_list.append(temp.data)
		
	temp = l._tail
	while temp.has_prev():
		backward_list.push_front(temp.data)
		temp = temp.prev
	backward_list.push_front(temp.data)
	
	#print("Forward_List: ", forward_list, "\nBackward List: ", backward_list) #TEST
	
	if forward_list.size() != backward_list.size():
		return false
		
	for i in forward_list.size():
		if forward_list[i] != backward_list[i]:
			return false
	
	return true
