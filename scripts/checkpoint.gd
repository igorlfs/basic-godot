extends Area2D

var is_active = false
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var marker_2d: Marker2D = $Marker2D


func _on_body_entered(body: Node2D) -> void:
	if body.name != "Player" or is_active:
		return
	activate_checkpoint()


func activate_checkpoint():
	Globals.current_checkpoint = marker_2d
	animated_sprite_2d.play("raising")
	is_active = true


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "raising":
		animated_sprite_2d.play("checked")
