extends Area2D

signal key_collected


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		remove_from_group("key")
		queue_free()
		key_collected.emit()
