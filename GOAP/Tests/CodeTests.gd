extends Node

@onready var test_goal = preload("res://GOAP/Tests/TestGoal.tres")

func _ready():
#	print(test_goal.is_valid())
#	print(ternary_return_test(true))
	var base_class = BaseTestClass.new(20, "Lamonaise")
	var inherited_class = InheritedTestClass.new(10, "dipearious", true)


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
