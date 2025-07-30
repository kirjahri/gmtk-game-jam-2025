extends Control

@export var strokes_label: Label


func update_strokes_label(strokes: int) -> void:
	strokes_label.text = "Strokes: %d" % strokes
