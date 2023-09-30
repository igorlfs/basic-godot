extends CharacterBody2D

@export var enemy_score := 150

@onready var anime: AnimatedSprite2D = $anime


func _on_hitbox_body_entered(_body: Node2D) -> void:
	anime.play("hurt")


func _on_anime_animation_finished() -> void:
	if anime.animation == "hurt":
		queue_free()
		Globals.score += enemy_score
