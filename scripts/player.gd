extends CharacterBody2D

signal player_has_died

const SPEED = 100.0
const JUMP_FORCE = -350.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jumping := false
var knockback_vector := Vector2.ZERO
var direction
var is_hurt := false

@onready var animation := $Anim as AnimatedSprite2D
@onready var remote_transform := $Remote as RemoteTransform2D
@onready var ray_right := $Ray_Right as RayCast2D
@onready var ray_left := $Ray_Left as RayCast2D


func jump_common():
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_FORCE
		is_jumping = true
	elif is_on_floor():
		is_jumping = false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	jump_common()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		animation.scale.x = direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if knockback_vector != Vector2.ZERO:
		velocity = knockback_vector

	_set_state()
	move_and_slide()

	for platforms in get_slide_collision_count():
		var collision = get_slide_collision(platforms)
		if collision.get_collider().has_method("has_collided_with"):
			collision.get_collider().has_collided_with()


func _on_hurtbox_body_entered(_body: Node2D) -> void:
	if ray_right.is_colliding():
		take_damage(Vector2(-200, -200))
	elif ray_left.is_colliding():
		take_damage(Vector2(200, -200))


func follow_camera(camera: Camera2D) -> void:
	remote_transform.remote_path = camera.get_path()


func take_damage(knockback_force := Vector2.ZERO, duration := 0.25):
	if Globals.player_life > 0:
		Globals.player_life -= 1
	else:
		queue_free()
		emit_signal("player_has_died")

	if knockback_force != Vector2.ZERO:
		knockback_vector = knockback_force

		var knockback_tween := get_tree().create_tween()
		knockback_tween.parallel().tween_property(self, "knockback_vector", Vector2.ZERO, duration)
		animation.modulate = Color(1, 0, 0, 1)
		knockback_tween.parallel().tween_property(
			animation, "modulate", Color(1, 1, 1, 1), duration
		)

	is_hurt = true
	await get_tree().create_timer(.3).timeout
	is_hurt = false


func _input(event):
	if event is InputEventScreenTouch:
		jump_common()


func _set_state():
	var state = "idle"
	if is_hurt:
		state = "hurt"
	elif !is_on_floor():
		state = "jump"
	elif direction != 0:
		state = "run"

	if animation.name != state:
		animation.play(state)


func _on_head_collider_body_entered(body: Node2D) -> void:
	if body.has_method("break_sprite"):
		body.hit_points -= 1
		if body.hit_points < 0:
			body.break_sprite()
		else:
			body.animation_player.play("hit")
			body.create_coin()
