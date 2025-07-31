extends Area2D

signal goal_touched

var is_locked: bool = false


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player") or is_locked:
		return

	goal_touched.emit()


func lock() -> void:
	is_locked = true


func unlock() -> void:
	is_locked = false
