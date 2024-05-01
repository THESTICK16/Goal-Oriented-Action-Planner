extends Node

##Agent that recieves and carries out GOAP plans
class_name AgentGOAP

##The agent that will actually be performing the actions.
@export var agent: Node
##A list of golas that the agent can pursue
@export var _goals: Array[GoalGOAP]
##The goal the agent is currently pursuing
var _current_goal: GoalGOAP
##The plan the agent is currently conducting to reach its current goal
var _current_plan: Array[ActionGOAP]
##The step of the plan that agent is currently conducting
##Represents an index in the _current_plan array
var _current_plan_action: int

func _physics_process(delta):
	if _goals.is_empty():
		return
	
	var best_goal = get_highest_priority_goal()
	if _current_goal != best_goal:
		_current_goal = best_goal
		_current_plan = get_new_plan()
		_current_plan_action = 0
		
	if _current_plan[_current_plan_action].is_complete():
		set_step()
	
	_current_plan[_current_plan_action].perform_action(agent, delta)

func get_highest_priority_goal() -> GoalGOAP:
	if _goals.is_empty(): return null
	
	var best_goal = _goals[0]
	for goal in _goals:
		if goal.is_valid(self) and goal.get_priority() > best_goal.get_priority():
			best_goal = goal
	
	return best_goal

func get_new_plan() -> Array:
	#return goap.get_plan(_current_goal) #TODO implement proper methods in GOAP and planner and uncomment
	return []

##Checks if the current step of the plan has been completed and increments it if so
func set_step():
	var current_step: ActionGOAP = _current_plan[_current_plan_action]
	if current_step.is_complete() and _current_plan_action < _current_plan.size() - 1:
		_current_plan_action += 1
		current_step = _current_plan[_current_plan_action]
