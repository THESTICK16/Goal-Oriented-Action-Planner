extends Node

@onready var test_goal = preload("res://Tests/TestGoal.tres")

func _ready():
	#var q_test = QueueTest.new().run_tests()
	#var pq_test = PriorityQueueTest.new().run_tests()
	#var stack_test = StackTest.new().run_tests()
	#var linked_list_test = LinkedListTest.new().run_tests()
	
	var ar := [0,1,2,3,4,5,6,7,8,9]
	#ar.get(3)
	
	var agent = AgentGOAP.new()
	print(agent.agent)
	agent.agent = CharacterBody2D.new()
	print(agent.agent)
	
	
	#var ll = LinkedList.new()
	#for i in 10:
		#ll.append(i)
	#print(ll["3"])



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

#class FwdIterator:
	#var start
	#var curr
	#var end
	#var increment
#
	#func _init(start, stop, inc):
		#self.start = start
		#self.curr = start
		#self.end = stop
		#self.increment = inc
#
	#func is_done():
		#return (curr < end)
#
	#func do_step():
		#curr += increment
		#return is_done()
#
	#func _iter_init(arg):
		#curr = start
		#return is_done()
#
	#func _iter_next(arg):
		#return do_step()
#
	#func _iter_get(arg):
		#return curr
