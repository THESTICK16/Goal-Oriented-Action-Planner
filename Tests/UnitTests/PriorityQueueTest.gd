extends UnitTest
class_name PriorityQueueTest

var pq: PriorityQueue
var pq_cmp_to: PriorityQueue
var ctitems : Array[comparator_test_item] = []
var cmptoitems : Array[compare_to_test_item] = []

func run_before():
	const chars := "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
	randomize()
	for i in 10:
		
		var new_name: String = ""
		for j in (randi() % 26) + 1:
			if randi() % 2 != 0:
				new_name += chars[j + 26]
			else:
				new_name += chars[j] #chars[randi() % chars.length()]
			
		ctitems.append(comparator_test_item.new(new_name))
		cmptoitems.append(compare_to_test_item.new(new_name))

func run_before_each():
	pq = PriorityQueue.new(null, 
		func(offered: comparator_test_item, mid: comparator_test_item) -> int: 
		var result : int
		if offered._name.length() < mid._name.length():
			result = -1
		elif offered._name.length() == mid._name.length():
			result = 0
		else:
			result = 1
		#print(offered._name, ", ", mid._name, ", ", result)
		return result
			
		)
		
	pq_cmp_to = PriorityQueue.new()

func test_offer():
	
	#return  #TEST DELETE!
	
	test(pq.offer(ctitems[0]))
	for i in ctitems:
		#print(i)
		#test(pq.offer(i))
		pq.offer(i)
	test(pq.offer(comparator_test_item.new("")))
	#print(pq)
	test(is_PQ_sorted_properly_with_pqs_comparator(pq))
	
	pq.clear()
	var newctiitems = [comparator_test_item.new('12'), comparator_test_item.new('12345'), comparator_test_item.new("1"), comparator_test_item.new("1234"), comparator_test_item.new("123456"), comparator_test_item.new('12')]
	
	for i in newctiitems:
		pq.offer(i)
		
	#print(pq)
	#["1", "12", "12", "1234", "12345", "123456"]))
	test(is_PQ_sorted_properly_with_pqs_comparator(pq))
	
func test_binary_search_insert():
	for i in ["abc", "abCdEFG", "abcdeFg", "aBcDEFGhij", "abcdeFg", "abcDEFGHIJkL", "AbcDeFGHiJkLMNOpQrS", "AbCDefgHIJklMnOPqRSTu"]:
		#print(i)
		#test(pq.offer(i))
		pq.offer(comparator_test_item.new(i))
	#print(pq)
	test(is_PQ_sorted_properly_with_pqs_comparator(pq))
	
	#pq.clear()
	for i in ["abCdEFgH", "aBc", "aBCdeFgHiJk", "aBCdeFgHiJk", "abCdeFGhIJklmN", "abCdEfghIjKlM", "aBcdEFGhiJkLmNo", "AbCDEfgHIJKlMnop", "abcdefgHiJkLMNoPqrSTuVwX"]:
		#print(i)
		#test(pq.offer(i))
		pq.offer(comparator_test_item.new(i))
		if not is_PQ_sorted_properly_with_pqs_comparator(pq):
			print("Error occured with: ", i, " ::: ", pq, "\n\n")
	#print(pq)
	test(is_PQ_sorted_properly_with_pqs_comparator(pq))
	
func test_comparators():
	var test_strings = ["aBc", "deFG", "HiJkL", "mn", "OP", "q", "rsTUVWxyz"]
	var test_data = []
	for i in test_strings:
		test_data.append(comparator_test_item.new(i))
	test_data.shuffle()
		
	var sort_by_longer_string = PriorityQueue.new(null, func(offered, mid): return 1 if offered._name.length() > mid._name.length() else 0 if offered._name.length() == mid._name.length() else -1)
	var sort_by_shorter_string = PriorityQueue.new(null, func(offered, mid): return 1 if offered._name.length() < mid._name.length() else 0 if offered._name.length() == mid._name.length() else -1)
	var sort_alphabetically = PriorityQueue.new(null, func(offered: comparator_test_item, mid): return offered._name[0].nocasecmp_to(mid._name[0]))
	
	for i in test_data:
		sort_by_longer_string.offer(i)
		sort_alphabetically.offer(i)
		sort_by_shorter_string.offer(i)
	
	test(sort_by_longer_string.to_array()[0]._name == "q" and sort_by_longer_string.to_array()[6]._name == "rsTUVWxyz")
	#print("Sort by longer string: ", sort_by_longer_string)
	test(sort_by_shorter_string.to_array()[6]._name == "q" and sort_by_shorter_string.to_array()[0]._name == "rsTUVWxyz")
	#print("Sort by shorter string: ", sort_by_shorter_string)
	test(sort_alphabetically.to_array()[0]._name == "aBc" and sort_alphabetically.to_array()[6]._name == "rsTUVWxyz")
	#print("Sort  alphabetically: ", sort_alphabetically)

func test_default_comparator():
	for i in cmptoitems:
		pq_cmp_to.offer(i)
	test(is_PQ_sorted_properly_with_pqs_comparator(pq_cmp_to))
	
func is_PQ_sorted_properly_with_pqs_comparator(_pq: PriorityQueue): # Test for PQs with th comparator tht sorts comparator_test_items by name length (longest at front of queue)
	var last = _pq.to_array()[0]._name
	for i in _pq.to_array():
		if i._name.length() < last.length():
			return false
		last = i._name
	
	return true








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
