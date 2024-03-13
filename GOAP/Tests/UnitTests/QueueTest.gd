extends UnitTest
class_name QueueTest

var q : Queue
var q2 : Queue

func run_before_each():
	q = Queue.new()
	q2 = Queue.new()


func test_constructor():
	print(q._meta_data())
	var data = [0,1,2,3,4,5,6,7,8,9]
	var qu = Queue.new(data, 52, true)
	print(qu._meta_data())
	qu = Queue.new(null, -9, false)
	print(qu._meta_data())
	#TODO Test that max size initializes properly if data.size() is greater than max size
	var que = Queue.new([1,2,3,4,5,6,7], 3)
	test(que._max_size == 7)
	que = Queue.new(null, -5)
	
func test_offer():
	var full_q = Queue.new([0], 1)
	test(not full_q.offer(1))
	test(not full_q.contains(1))
	test(q.offer(999994838))
	test(q.offer(true))
	test(q.offer("String offer"))
	print(q.to_string())
	
func test_poll():
	q.offer(1)
	q.offer(2)
	q.offer(3)
	q.offer(4)
	q.offer(5)
	test(q.poll() == 1)
	test(q.poll() == 2)
	test(q.poll() == 3)
	test(q.poll() == 4)
	test(q.poll() == 5)
	
func test_peek():
	test(q.peek() == null)
	q.offer(1)
	test(q.peek() == 1)
	q.offer(2)
	test(q.peek() == 1)
	q.poll()
	test(q.peek() == 2)
	q.offer(3)
	q.offer(4)
	test(q.peek() == 2)
	q.poll()
	test(q.peek() == 3)
	q.poll()
	test(q.peek() == 4)
	q.poll()
	q.offer(5)
	test(q.peek() == 5)
	
func test_contains():
	q.offer(1)
	q.offer(2)
	q.offer(3)
	q.offer(4)
	q.offer(5)
	test(q.contains(3))
	test(q.contains(4))
	test(q.contains(1))
	test(not q.contains(0))
	test(not q.contains(6))
	test(not q.contains(603))
	test(not q.contains(30))
	
func test_size():
	for i in range(1, 27):
		q.offer(i)
		test(q.size() == i)
	
func test_to_array():
	q.offer(1)
	q.offer(2)
	q.offer(3)
	q.offer(4)
	q.offer(5)
	var a = q.to_array()
	test(typeof(a) == TYPE_ARRAY)
	test(a[3] == 4)
	test(a[0] == 1)
	
func test_clear():
	q.offer(1)
	q.offer(2)
	q.offer(3)
	q.offer(4)
	q.offer(5)
	test(q.size() != 0)
	q.clear()
	test(q.size() == 0)
	
func test_is_full():
	var full_q = Queue.new([0], 1)
	test(full_q.is_full())
	test(not q.is_full())
	full_q.poll()
	test(not full_q.is_full())
	
func test_to_string():
	var new_q = Queue.new([1, "test", false, 3.342], 5, false)
	var test_string = str([1, "test", false, 3.342]) #"Data: " + str([1, "test", false, 3.342]) + "\nMax Size: " + str(5) + "\nPrioritize Additions: " + str(false)
	var q_string = new_q._to_string()
	test(q_string == test_string)
	
func test_set_prioritize_additions():
	var pri_add_q = Queue.new(null, -1, true) # Queue with prioritize additions set to true
	var pri_rem_q = Queue.new(null, -1, false) # Queue with prioritize additions set to false
	
	print(pri_add_q._meta_data())
	
	var q_items = ["Front", 1, 2, 3, "Back"]
	for i in q_items:
		pri_add_q.offer(i)
		pri_rem_q.offer(i)
	
	test(pri_add_q.to_array()[0] == "Front")
	test(pri_add_q.to_array()[4] == "Back")
	test(pri_rem_q.to_array()[0] == "Back")
	test(pri_rem_q.to_array()[4] == "Front")
	
	pri_add_q.poll()
	pri_rem_q.poll()
	test(pri_add_q.to_array()[0] == 1)
	test(pri_add_q.to_array()[3] == "Back")
	test(pri_rem_q.to_array()[0] == "Back")
	test(pri_rem_q.to_array()[3] == 1)
