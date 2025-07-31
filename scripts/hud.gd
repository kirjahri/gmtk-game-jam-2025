extends Control

@export var strokes_label: Label
@export var stopwatch_label: Label


func update_strokes_label(strokes: int) -> void:
	strokes_label.text = "Strokes: %d" % strokes


func update_stopwatch_label(time: float) -> void:
	var milliseconds: float = fmod(time, 1) * 1000
	var seconds: float = fmod(time, 60)
	var minutes: float = time / 60

	stopwatch_label.text = "%02d:%02d:%03d" % [minutes, seconds, milliseconds]
