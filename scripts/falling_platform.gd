extends AnimatableBody2D

@export var reset_timer := 3.0

var velocity := Vector2.ZERO
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_triggered := false

@onready var anim := $Animation as AnimationPlayer
@onready var respawn_timer = get_node("Respawn_Timer") as Timer
@onready var respawn_position = global_position


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_physics_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	position += velocity * delta


func has_collided_with():
	if !is_triggered:
		is_triggered = true
		anim.play("shake")
		velocity = Vector2.ZERO


func _on_animation_animation_finished(_anim_name: StringName) -> void:
	set_physics_process(true)
	respawn_timer.start(reset_timer)


func _on_respawn_timer_timeout() -> void:
	set_physics_process(false)
	global_position = respawn_position
	if is_triggered:
		var spawn_tween = create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN_OUT)
		spawn_tween.tween_property($Texture, "scale", Vector2(1, 1), 0.2).from(Vector2(0, 0))
	is_triggered = false
