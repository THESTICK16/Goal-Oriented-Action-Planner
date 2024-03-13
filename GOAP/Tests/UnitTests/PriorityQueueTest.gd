extends UnitTest
class_name PriorityQueueTest

var pq: PriorityQueue
var pq_cmp_to: PriorityQueue
var ctitems : Array[comparator_test_item] = []
var cmptoitems : Array[compare_to_test_item] = []

func run_before():
	const chars := "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
	randomize()
	for i in 25:
		
		var new_name: String = ""
		for j in (randi() % 18):
			new_name += chars[randi() % chars.length()]
			
		ctitems.append(comparator_test_item.new(new_name))
		cmptoitems.append(compare_to_test_item.new(new_name))

func run_before_each():
	pq = PriorityQueue.new(ctitems)
	pq_cmp_to = PriorityQueue.new(cmptoitems)
	
func test_comparators():
	pass

func test_default_comparator():
	pass
	
func test_offer():
	pass
	
func test_binary_search_insert():
	pass







class comparator_test_item extends Resource:
	var _name: String
	
	func _init(name: String):
		_name = name
	
	func _to_string():
		return _name

class compare_to_test_item extends comparator_test_item:
	
	#var _name: String
	
	#func _init(name: String):
		#_name = name
		
	func compare_to(comparison: compare_to_test_item):
		if _name.length() < comparison._name.length():
			return -1
		elif _name.length() > comparison._name.length():
			return 1
		else:
			return 0
	
	#func _to_string():
		#return _name
