extends CharacterBody2D

@export var sprite: Sprite2D

@export var speed: float = 300.0
@export var acceleration: float = 300.0
@export var deacceleration: float = 300.0
@export var sprint_multiplier: float = 2.0
@export var jump_velocity: float = -400.0
@export var terminal_velocity: float = 600.0

@onready var viewport_size: Vector2 = get_viewport_rect().size
@onready var half_of_width: float = sprite.texture.get_size().x / 2


func _physics_process(delta: float) -> void:
	var direction: float = Input.get_axis("move_left", "move_right")

	if not is_on_floor():
		velocity += get_gravity() * delta
		velocity.y = min(velocity.y, terminal_velocity)

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	if not direction == 0.0:
		if Input.is_action_pressed("sprint"):
			velocity.x = move_toward(
				velocity.x, speed * sprint_multiplier * direction, acceleration * delta
			)
			rotation += velocity.x / 5000  # likely a horrid way of doing this but it's gonna have to do for now
		else:
			velocity.x = move_toward(velocity.x, speed * direction, acceleration * delta)
			rotation += velocity.x / 5000
	else:
		velocity.x = move_toward(velocity.x, 0.0, deacceleration * delta)
		rotation += velocity.x / 5000

	if (
		Input.is_action_pressed("duck")
		and is_on_floor()
		and get_last_slide_collision().get_collider().is_in_group("platform")
	):
		position.y += 1

	global_position = Vector2(
		wrapf(global_position.x, 0, viewport_size.x), wrapf(global_position.y, 0, viewport_size.y)
	)

	move_and_slide()
