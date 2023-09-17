extends Node2D

const WAIT_DURATION := 1.0

@export var move_speed := 3.0
@export var distance := 192
@export var moving_horizontally := true

var follow := Vector2.ZERO
var platform_center := 16

@onready var platform := $Platform as AnimatableBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	move_platform()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	platform.position = platform.position.lerp(follow, 0.5)


func move_platform() -> void:
	var move_direction = Vector2.RIGHT * distance if moving_horizontally else Vector2.UP * distance
	var duration = move_direction.length() / float(move_speed * platform_center)
	var platform_tween = create_tween().set_loops().set_trans(Tween.TRANS_LINEAR).set_ease(
		Tween.EASE_IN_OUT
	)
	platform_tween.tween_property(self, "follow", move_direction, duration).set_delay(WAIT_DURATION)
	platform_tween.tween_property(self, "follow", Vector2.ZERO, duration).set_delay(
		duration + WAIT_DURATION
	)
