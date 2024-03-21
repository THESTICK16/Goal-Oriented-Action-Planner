extends Node

@onready var test_goal = preload("res://GOAP/Tests/TestGoal.tres")

func _ready():
	#var unit_test = UnitTest.new().run_tests()
	#for i in 100:
		#var q_test = PriorityQueueTest.new()
		#if not q_test.run_tests():
			#push_error("Failed Test #", i)
	var q_test = PriorityQueueTest.new()
	q_test.run_tests()
	



func test_callables():
	var comparator : Callable = compare_to #func(one, two): 
#		if one == two: return 0
#		return 1 if one > two else -1
	
	var result : int = comparator.call(3, 4)
	print(result)
	
func compare_to(one, two): 
	return 1 if one > two else 0 if one == two else -1
	#if one == two: return 0
	#return 1 if one > two else -1

func ternary_return_test(test_bool: bool):
#	return 1 if test_bool else 0
	var data = [1, 2, 3, 4, 10, 20]
	data.pop_front() if test_bool else data.pop_back()
	print(data)


class BaseTestClass extends Resource:
	
	var test_var_1 : int
	var test_var_2 : String
	
	func _init(var1: int, var2: String):
		test_var_1 = var1
		test_var_2 = var2
		print(to_string())
		
	func _to_string():
		return str(test_var_1) + " " + str(test_var_2)
		

class InheritedTestClass extends BaseTestClass:
	var test_var_3
	
	
	func _init(var1: int, var2: String, var3: bool):
		super(var1, var2)
		test_var_3 = var3
		print(to_string())
		
	func _to_string():
		return str(test_var_1) + " " + str(test_var_2 + " " + str(test_var_3))
