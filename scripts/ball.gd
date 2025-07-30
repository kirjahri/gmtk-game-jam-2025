extends CharacterBody2D

@export var sprite: Sprite2D

@export var speed: float = 300.0
@export var sprint_multipolier: float = 2.0
@export var jump_velocity: float = -400.0

@onready var viewport_size: Vector2 = get_viewport_rect().size
@onready var half_of_width: float = sprite.texture.get_size().x / 2


func _physics_process(delta: float) -> void:
	var direction: float = Input.get_axis("move_left", "move_right")

	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	if not direction == 0.0:
		if Input.is_action_pressed("sprint"):
			velocity.x = speed * sprint_multipolier * direction
		else:
			velocity.x = speed * direction
	else:
		velocity.x = 0.0

	global_position = Vector2(
		wrapf(global_position.x, 0 - half_of_width, viewport_size.x + half_of_width),
		wrapf(global_position.y, 0 - half_of_width, viewport_size.y + half_of_width)
	)

	move_and_slide()
