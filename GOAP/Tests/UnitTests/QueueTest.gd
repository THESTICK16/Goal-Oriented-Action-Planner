extends Resource
class_name QueueTest

var q : Queue
var q2 : Queue

var tests_run := 0 : set = set_tests_run # The number big tests run. i.e. The number of functions in the main object tested
var tests_within_tests_run := 1 # the number of mini tests within each function called. i.e. calls to 'test()' within each test function. resets to zero every time 'tests_run' is incremented
var failure_count := 0 # The number of tests failed
var pass_count := 0 # The number of tests passed

func _init():
	q = Queue.new()
	q2 = Queue.new([1,2,3,4,5,6,7,8,9,10])
	run_tests()
	
func run_tests(q : Queue = Queue.new()):
	test_constructor()
	test_offer()
	test_poll()
	test_peek()
	test_contains()
	test_size()
	test_to_array()
	test_clear()
	test_is_full()
	test_to_string()
	test_set_prioritize_additions()
	print("Tests Completed\nTests passed: ", str(pass_count), "\nTests failed: ", str(failure_count))
	
func test_constructor():
	tests_run += 1
	
	var data = [0,1,2,3,4,5,6,7,8,9]
	var qu = Queue.new(data, 52, true)
	print(qu._meta_data())
	qu = Queue.new(null, -9, false)
	print(qu._meta_data())
	
func test_offer():
	tests_run += 1
	
	var full_q = Queue.new([0], 1)
	test(not full_q.offer(1))
	
	for i in range(0,150, 27):
		test(q.offer(i))
	
func test_poll():
	tests_run += 1
	
func test_peek():
	tests_run += 1
	
func test_contains():
	tests_run += 1
	
func test_size():
	tests_run += 1
	
func test_to_array():
	tests_run += 1
	
func test_clear():
	tests_run += 1
	
func test_is_full():
	tests_run += 1
	
func test_to_string():
	tests_run += 1
	
func test_set_prioritize_additions():
	tests_run += 1
	
func test(test : bool):
	if not test:
		print("Test #: ", str(tests_within_tests_run), " FAILED ---------------------------------------------------------------------------------------")
		failure_count += 1
	else:
		pass_count += 1
	tests_within_tests_run += 1
	
	
func set_tests_run(num_run: int):
	tests_run = num_run
	tests_within_tests_run = 1 # Resets the tests within the function to show which test is failing
	print("TEST " + str(tests_run))
	
