extends Node2D

@export_group("Line")
@export var strokes: int = 5
@export var max_line_length: float = 200.0
@export var line_color: Color

@export_group("Goal")
@export var goal: Area2D

@export_group("HUD")
@export var hud: Control

var last_valid_mouse_pos: Vector2


func _ready() -> void:
	hud.update_strokes_label(strokes)

	for child: Node in get_children():
		if child.is_in_group("key"):
			child.key_collected.connect(_on_key_collected)

			if not goal.is_locked:
				goal.lock()

	goal.goal_touched.connect(_on_goal_touched)


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("left_click") and strokes > 0:
		var line: Line2D = Line2D.new()

		line.default_color = line_color

		line.joint_mode = Line2D.LINE_JOINT_ROUND
		line.begin_cap_mode = Line2D.LINE_CAP_ROUND
		line.end_cap_mode = Line2D.LINE_CAP_ROUND

		line.add_point(get_global_mouse_position())
		line.add_point(get_global_mouse_position())

		add_child(line)

	if Input.is_action_just_released("left_click"):
		for child: Node in get_children():
			if child is Line2D and not child.is_in_group("complete_line"):
				if child.get_point_position(0) == child.get_point_position(1):
					child.queue_free()
					return

				child.add_to_group("complete_line")

				strokes -= 1
				hud.update_strokes_label(strokes)

				# Add collision to the line
				for i: int in child.points.size() - 1:
					var static_body: StaticBody2D = StaticBody2D.new()
					var collision_shape: CollisionShape2D = CollisionShape2D.new()

					child.add_child(static_body)
					static_body.add_child(collision_shape)

					var segment_shape: SegmentShape2D = SegmentShape2D.new()
					segment_shape.a = child.points[i]
					segment_shape.b = child.points[i + 1]

					collision_shape.shape = segment_shape

	for child: Node in get_children():
		if child is Line2D and not child.is_in_group("complete_line"):
			if (
				child.get_point_position(0).distance_to(get_global_mouse_position())
				> max_line_length
			):
				child.set_point_position(1, last_valid_mouse_pos)
			else:
				child.set_point_position(1, get_global_mouse_position())
				last_valid_mouse_pos = get_global_mouse_position()

	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()


func _on_key_collected() -> void:
	for child: Node in get_children():
		if child.is_in_group("key"):
			return

	goal.unlock()
	print("unlocked")


func _on_goal_touched() -> void:
	print("you win!!!")
