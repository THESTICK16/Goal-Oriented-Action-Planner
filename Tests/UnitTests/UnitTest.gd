extends Resource
class_name UnitTest

signal test_finished

## The prefix with which all 'test' functions must begin with. 
## If a 'test' function name does not begin with this prefix it will not run.
const TEST_FUNC_PREFIX = 'test_'

## The number of function tests run (i.e. functions that start with TEST_FUNC_PREFIX)
var _tests_run := 0 #: set = _set_tests_run 
## the number of mini tests within a function called so far. 
## i.e. The elapsed number of calls to 'test()' within each test function. 
## Resets to zero every time 'tests_run' is incremented.
var _tests_within_tests_run := 0
## The number of function tests failed
var _failure_count := 0 
## The number of function tests passed
var _pass_count := 0 
## Used within 'run_tests' to determine if a function tet has passed or failed.
## Restes to true each time a new test function is called.
var _test_passed := true
## Used within 'test' and 'run_tests' to determine which individual calls to 'test' failed.
## Is emptied each time a new test function is called.
var _failures := []


func run_tests() -> bool:
	run_before()
	
	for method in get_method_list():
		var meth_name : String = method.get('name')
		#print(meth_name)
		
		if not meth_name.to_lower().begins_with(TEST_FUNC_PREFIX):
			continue
		
		_test_passed = true
		run_before_each()
		call(meth_name)
		run_after_each()
		_tests_run += 1
		_establish_test_results(meth_name)
		
	run_after()
	
	print_rich("[b][color=cyan]---------------------------------------" + str(resource_path) + " Tests Complete----------------------------------------------[/color]")
	print_rich("[b][color=white][b]Tests Run: " + str(_tests_run) + "[/b][/color]")
	print_rich("[color=green][b]Tests Passed: " + str(_pass_count) + "[/b][/color]")
	if _failure_count > 0:
		print_rich("[color=orange][b]Tests Failed: " + str(_failure_count) + "[/b][/color]")
	print_rich("[b][color=cyan]-----------------------------------------------------------------------------------------------------")
		
	emit_signal("test_finished")
	return _failure_count <= 0

func test(test_ : bool):
	if not test_:
		#print("FAIL --> Test #: ", str(_tests_within_tests_run + 1), " FAILED ---------------------------------------------------------------------------------------")
		#_failure_count += 1
		_failures.append(str(_tests_within_tests_run + 1))
		_test_passed = false
		
	#else:
		#_pass_count += 1
		
	_tests_within_tests_run += 1
	
#func _set_tests_run(num_run: int):
	#_tests_run = num_run
	#_tests_within_tests_run = 1 # Resets the tests within the function to show which test is failing
	#print("TEST " + str(_tests_run))
	
func _establish_test_results(test_name):
	if _test_passed:
		_pass_count += 1
		print_rich("[color=green]Test: " + test_name + " PASSED[/color]")
	else:
		_failure_count += 1
		print_rich("[color=orange]Test: " + test_name + " FAILED[/color]")
		for failure in _failures:
			print_rich("[indent][i]--test call #" + str(failure) + " failed")
	_failures.clear()
	_tests_within_tests_run = 0

# --------------------------------Virtual Functions-----------------------------------------

## VIRTUAL FUNCTION
## Runs exactly one time, before any tests have run
func run_before():
	pass

## VIRTUAL FUNCTION
## Runs immediately before each test runs
func run_before_each():
	pass

## VIRTUAL FUNCTION
## Runs exactly one time, after all tests have run
func run_after():
	pass

## VIRTUAL FUNCTION
## Runs immediately after each test runs
func run_after_each():
	pass
