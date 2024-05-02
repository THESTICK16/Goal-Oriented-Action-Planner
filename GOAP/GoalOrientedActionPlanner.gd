extends Node

##Global AutoLoad
##A Goal Oriented Action Planner (GOAP) system for agent A.I.
##Generates plans for A.I. agents to follow to reach a given goal.
class_name GoalOrientedActionPlanner

##The filepath to the folder containing the AgentGoap resources
const agents_path := ""
##The filepath to the folder containing the GoalGoap resources
const goals_path := ""
##The filepath to the folder containing the ActionGoap resources
const actions_path := ""

##The world state for the GOAP
var world_state: WorldStateGOAP
##The GOAP planner
var planner: PlannerGOAP
##A list of all agents that will rely utilize the GOAP
var agents: Array[AgentGOAP]
##A List of all the possible goals for the GOAP
var goals: Array[GoalGOAP]
##A List of all the possible actions for the GOAP
var actions: Array[ActionGOAP]


func _ready():
	print("Hello GOAP")
	world_state = WorldStateGOAP.new()
	planner = PlannerGOAP.new()
	agents = initialize_agents(agents_path)
	goals = initialize_goals(goals_path)
	actions = initialize_actions(actions_path)
	

func initialize_agents(filepath: String) -> Array:
	return []

func initialize_goals(filepath: String) -> Array:
	return []

func initialize_actions(filepath: String) -> Array:
	return []

##Creates and returns a copy of the world state.
##Changing the values of this world state will have no effect on the true world state of the GOAP.
##This copy is intended to be used by the planner to create plans.
func get_temp_world_state() -> Dictionary:
	return world_state.world_state.duplicate(true)
