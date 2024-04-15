extends Queue

## A "last in first out" stack.
## Returns elements in order of addition starting with the most recent.
class_name Stack

func _init(data=null, max_size:=-1):
	super(data, max_size, false)


## Inserts the specified element into this stack if it is possible to do so immediately without violating capacity restrictions.
func offer(item) -> bool:
	if _max_size > 0 and _data.size() >= _max_size:
		return false
		
	_data.push_back(item)
	return true
