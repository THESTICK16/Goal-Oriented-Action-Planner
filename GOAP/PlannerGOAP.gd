extends Resource

##The planner for the Goal Oriented Action Planner.
##Takes goals as inputs and generates appropriate plans for the agent to reach it.
class_name PlannerGOAP

func generate_plan(goal: GoalGOAP, agent: AgentGOAP) -> Array:
	#var action_comparator = func(action1: ActionGOAP, action2: ActionGOAP): 
		#if action1.a_star_total_cost > action2.a_star_total_cost:
			#return -1
		#elif action1.a_star_total_cost == action2.a_star_total_cost:
			#return 0
		#else: # i.e. action1.a_star_total_cost > action2.a_star_total_cost:
			#return 1
	
	var plan_comparator: Callable #TODO implement plan_comparator as callable
	var open: PriorityQueue = PriorityQueue.new(null, plan_comparator)
	var closed := []
	
	#TODO implement A* algorithm that creates plans (as arrays), and adds them to open and closed as needed. Look up more resources on how to do this
	var sample_plan_to_be_deleted = {
		"cost": 0,
		"steps": [] #Comprised of "ActionGoap"s
	}
	
	
	return[]


