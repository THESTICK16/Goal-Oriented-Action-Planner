extends Queue

class_name PriorityQueue

var _comparator: Callable: set = _private_setter, get = _private_getter # (Maybe) Create a new class called Comparator and change this from callable to comparator. See Java Docs for details

func _init(data=null, max_size=0, prioritize_additions=false, comparator=null):
#	push_warning("TEST THIS TO SEE  EXACTLY HOW CALLING SUPER WORKS")
	super(data, max_size, prioritize_additions)
	_comparator = comparator
	


func offer(item) -> bool:
	return false
	





func _private_setter(new):
	push_warning("You are attempting to access a private variable which cannot be accessed externally")

func _private_getter():
	push_warning("You are attempting to access a private variable which cannot be accessed externally")

