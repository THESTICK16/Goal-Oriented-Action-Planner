extends UnitTest
class_name StackTest

var s : Queue
var s2 : Queue

func run_before_each():
	s = Stack.new()
	s2 = Stack.new()

func test_offer():
	for i in 10:
		s.offer(i)
		
	test(s.peek() == 9)
	
	for i in range(9, -1, -1):
		test(s.poll() == i)
		
	test(s.size() == 0)
	
