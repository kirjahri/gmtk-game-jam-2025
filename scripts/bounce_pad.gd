extends Area2D

@export var bounce_velocity: float = -400.0


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.velocity.y = bounce_velocity
