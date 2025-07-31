extends Area2D

enum Direction { LEFT, RIGHT, UP, DOWN }

@export var bounce_speed: float = 400.0
@export var direction: Direction


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		match direction:
			Direction.LEFT:
				body.velocity.x = -bounce_speed
			Direction.RIGHT:
				body.velocity.x = bounce_speed
			Direction.UP:
				body.velocity.y = -bounce_speed
			Direction.DOWN:
				body.velocity.y = bounce_speed
