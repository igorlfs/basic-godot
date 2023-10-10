extends Area2D

var coins := 1

@onready var anim: AnimatedSprite2D = $Anim
@onready var collision: CollisionShape2D = $Collision
@onready var coin_sfx: AudioStreamPlayer = $AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_body_entered(_body: Node2D) -> void:
	anim.play("collect")
	coin_sfx.play()
	# Evita colisão dupla
	collision.queue_free()
	Globals.coins += coins


func _on_anim_animation_finished() -> void:
	queue_free()
