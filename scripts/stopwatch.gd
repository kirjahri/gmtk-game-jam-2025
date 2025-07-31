extends Node

@export_group("Goal")
@export var goal: Area2D

@export_group("HUD")
@export var hud: Control

var elapsed_time: float = 0.0
var is_stopped: bool = false


func _ready() -> void:
	goal.goal_touched.connect(_on_goal_touched)


func _process(delta: float) -> void:
	if is_stopped:
		return

	elapsed_time += delta
	hud.update_stopwatch_label(elapsed_time)


func _on_goal_touched() -> void:
	is_stopped = true
