extends Node2D

@onready var player := $Player as CharacterBody2D
@onready var camera := $Camera as Camera2D
@onready var control: Control = $HUD/Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.follow_camera(camera)
	player.player_has_died.connect(reload_game)
	control.time_is_up.connect(reload_game)
	Globals.coins = 0
	Globals.score = 0
	Globals.player_life = Globals.NUM_PLAYER_LIVES


func reload_game():
	await get_tree().create_timer(1.0).timeout
	get_tree().reload_current_scene()
