extends RigidBody2D

@export var sprite: Sprite2D

@onready var viewport_size: Vector2 = get_viewport_rect().size
@onready var half_of_width: float = sprite.texture.get_size().x / 2


func _physics_process(_delta: float) -> void:
	global_position = Vector2(
		wrapf(global_position.x, 0 - half_of_width, viewport_size.x + half_of_width),
		wrapf(global_position.y, 0 - half_of_width, viewport_size.y + half_of_width)
	)
