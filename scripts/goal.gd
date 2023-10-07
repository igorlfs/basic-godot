extends Area2D

@export var next_level: String = ""

@onready var transition = get_node("../Transition")


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" and next_level != "":
		transition.change_scene(next_level)
