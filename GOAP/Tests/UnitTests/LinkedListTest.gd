extends UnitTest
class_name LinkedListTest

var ll: LinkedList

func run_before_each():
	ll = LinkedList.new()

func test_constructor():
	pass
	
func test_add():
	for i in 10:
		ll.__add(i, i)
		test(ll.size() == i + 1)
		test(ll._tail.data == i)
	
	test(ll.to_string() == "[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]")
	
	ll.__add(5, 'five')
	test(ll.to_string() == "[0, 1, 2, 3, 4, five, 5, 6, 7, 8, 9]")
	ll.__add(7, 100)
	test(ll.to_string() == "[0, 1, 2, 3, 4, five, 5, 100, 6, 7, 8, 9]")

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
	
	#print(ll)
	
func test_remove():
	test(ERR_PARAMETER_RANGE_ERROR == ll.__remove(0))
	test(ERR_PARAMETER_RANGE_ERROR == ll.__remove(1))
	test(ERR_PARAMETER_RANGE_ERROR == ll.__remove(10))
	
	for i in 10:
		ll.__add(i, i)
	
	test(OK == ll.__remove(0))
	test(ll._head.data == 1)
	test(ll.size() == 9)
	test(OK == ll.__remove(ll.size() - 1))
	test(ll._tail.data == 8)
	test(ll.size() == 8)
	
	test(OK == ll.__remove(3))
	test(OK == ll.__remove(6))
	test(ERR_PARAMETER_RANGE_ERROR == ll.__remove(-1))
	test(ERR_PARAMETER_RANGE_ERROR == ll.__remove(11))
	test(ERR_PARAMETER_RANGE_ERROR == ll.__remove(ll.size()))
	test(ERR_PARAMETER_RANGE_ERROR == ll.__remove(100))
	
	while ll._size > 0:
		test(OK == ll.__remove(ll.size() - 1))
		
	test(ll.size() == 0)
	
func test_to_string():
	pass
