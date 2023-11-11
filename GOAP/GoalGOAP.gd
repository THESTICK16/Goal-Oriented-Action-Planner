extends Resource

## Abstract class for a Goal in the Goal Oriented Action Planning System.
## Should be inherited from for each individual goal in the GOAP system.
class_name GoalGOAP

## A dictionary of world state vriables and values that represent a "completed" state for this goal
@export var desired_state: Dictionary : get = get_desited_state

@export_group("Priority")
## The highest value that can be retrieved from this priority. 
## If "priority" is set to be greater than priority_ceiling, priority_ceiling will be returned.
## Range: Must be a integer between 1 and 10
@export_range(MIN_PRIORITY, MAX_PRIORITY, 1) var priority_ceiling := 10 : set = set_priority_ceiling
## The default priority assigned to the goal. 
## To enable dynamic priority generation at runtime, the "get_priority" function should be overridden.
## Range: Must be a integer between 1 and 10
@export_range(MIN_PRIORITY, MAX_PRIORITY, 1) var priority: int : set = set_priority, get = get_priority

## The minimum value priority may be set to
const MIN_PRIORITY := 1
## The maximum value priority may be set to
const MAX_PRIORITY := 10

func set_priority(new_priority: int):
	priority = clampi(new_priority, MIN_PRIORITY, priority_ceiling)

## VIRTUAL METHOD
## A basic getter for a goal's "priority".
## This function is intended to be overriden for dynamic priority determination.
## All get_priority overrides should remember to check that priority does not fall out of the bounds of MIN_PRIORITY--priority_ceiling/MAX_PRIORITY
func get_priority():
	return clampi(priority, MIN_PRIORITY, priority_ceiling)
	
func set_priority_ceiling(new_ceiling: int):
	priority_ceiling = clampi(new_ceiling, MIN_PRIORITY, MAX_PRIORITY)
	
func get_desited_state():
	return desired_state.duplicate(true)
	
## VIRTUAL METHOD
## Determines if it is feasible for the given agent parameter to pursue the Goal
## @param agent: the "Agent" for which the validity of the Goal is to be determined
## @return true if the agent can and shoudl pursue the Goal, else false.
func is_valid(agent: AgentGOAP) -> bool:
	push_error("\"is_valid\" returns false by default and must be overriden by all GoalGOAP resources")
	return false
