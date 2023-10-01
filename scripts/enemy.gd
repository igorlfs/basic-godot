class_name EnemyBase

extends CharacterBody2D

const SPEED = 700.0
const JUMP_VELOCITY = -400.0

@export var enemy_score := 100

var wall_detector
var texture
var direction := -1
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var can_spawn = false
var spawn_instance: PackedScene = null
var spawn_instance_position

@onready var anime := $Anime


func _apply_gravity(delta: float):
	if not is_on_floor():
		velocity.y += gravity * delta


func movement(delta: float):
	velocity.x = direction * SPEED * delta

	move_and_slide()


func kill_ground_enemy(anim_name: StringName):
	if anim_name == "hurt":
		kill_and_score()


func kill_air_enemy():
	kill_and_score()


func kill_and_score():
	Globals.score += enemy_score
	if can_spawn:
		spawn_new_enemy()
		get_parent().queue_free()
	else:
		queue_free()


func spawn_new_enemy():
	var instance_scene = spawn_instance.instantiate()
	get_tree().root.add_child(instance_scene)
	instance_scene.global_position = spawn_instance_position.global_position


func flip_direction():
	if wall_detector.is_colliding():
		direction *= -1
		wall_detector.scale.x *= -1

	texture.flip_h = true if direction == 1 else false


func _on_hitbox_body_entered(_body: Node2D) -> void:
	anime.play("hurt")
