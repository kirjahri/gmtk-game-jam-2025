extends Node2D

@export var strokes: int = 5

@export var line_color: Color

@export var hud: Control


func _ready() -> void:
	hud.update_strokes_label(strokes)


func _process(_delta: float) -> void:
	for child: Node in get_children():
		if child is Line2D and not child.is_in_group("complete_line"):
			child.set_point_position(1, get_global_mouse_position())


func _input(_event: InputEvent) -> void:
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
