extends Resource

## Abstract class for an Action in the Goal Oriented Action Planning System.
## Should be inherited from for each individual action in the GOAP system.
class_name ActionGOAP

## A dictionary of world state variables and values that must be true on order for the action to be a valid option for the agent to execute.
@export var action_preconditions: Dictionary : get = get_action_preconditions
## A dictionary of world state variables and values that will be true upon completion of the action.
@export var action_effects: Dictionary : get = get_action_effects
## The cost for the agent to perform this action. 
## To enable dynamic cost generation at runtime, the "get_cost" function should be overridden.
@export var cost: float : get = get_cost

## VIRTUAL METHOD.
## Determines if it is feasible for the given agent parameter to perform the Action
## @param agent: the "Agent" for which the validity of the Goal is to be determined
## @return true if the agent can and should perform the Action, else false.
func is_valid(agent: AgentGOAP) -> bool:
	push_error("\"is_valid\" returns false by default and must be overriden by all ActionGOAP resources")
	return false

## VIRTUAL METHOD.
## Contains the logic for performing the action, called on every loop.
## @param agent: the "Agent" that will be performing the action. Agent functions should be called directly in "perform_action".
## @param _delta: The delta time variable used in process/physics_process
## @return true upon completion of the action, false while the action is still being performed
func perform_action(agent, _delta: float) -> bool: # func perform_action(agent: AgentGOAP, behavior: Callable) -> bool:
	# TODO An alternative implementation could involve passing all virtual methods like this function a lambda function, thereby eliminating the need to override these functions and create a new script for every single action/goal/etc.
	push_error("\"perform_action\" returns false by default and must be overriden by all ActionGOAP resources")
	return false

func get_action_preconditions() -> Dictionary:
	return action_preconditions.duplicate(true)
	
func get_action_effects() -> Dictionary:
	return action_effects.duplicate(true)

## VIRTUAL METHOD.
## A basic getter for an actions's "cost".
## This function is intended to be overriden for dynamic cost calculation.
## @return the cost for the Agent to perform the action
func get_cost() -> float:
	return cost

## VIRTUAL METHOD.
## Determines if the action has been completed and returns true if so
## This function is designed to be overriden for each individual action
## @return true if the criteria for completing the action has been achieved, else false
func is_complete() -> bool:
	push_error("\"is_complete\" returns false by default and must be overriden by all ActionGOAP resources")
	return false
