extends CharacterBody2D

const SPEED = 700.0
const JUMP_VELOCITY = -400.0

@export var to_right := false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var wall_detector := $Wall_Detector as RayCast2D
@onready var texture := $Texture as Sprite2D
@onready var anime := $Anim as AnimationPlayer


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if wall_detector.is_colliding():
		to_right = !to_right
		wall_detector.scale.x *= -1
		texture.flip_h = to_right

	velocity.x = SPEED * delta
	if !to_right:
		velocity.x *= -1

	move_and_slide()


func _on_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name == "hurt":
		queue_free()
