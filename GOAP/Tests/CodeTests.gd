extends Node

@onready var test_goal = preload("res://GOAP/Tests/TestGoal.tres")

func _ready():
	print(test_goal.is_valid())
