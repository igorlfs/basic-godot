extends Node2D

@onready var player := $Player as CharacterBody2D
@onready var player_scene := preload("res://actors/player.tscn")
@onready var camera := $Camera as Camera2D
@onready var control: Control = $HUD/Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.player = player
	Globals.player.follow_camera(camera)
	Globals.player.player_has_died.connect(reload_game)
	control.time_is_up.connect(reload_game)


func reload_game():
	await get_tree().create_timer(1.0).timeout
	player = player_scene.instantiate()
	add_child(player)
	Globals.player = player
	Globals.player.follow_camera(camera)
	Globals.player.player_has_died.connect(reload_game)
	Globals.coins = 0
	Globals.score = 0
	Globals.player_life = Globals.NUM_PLAYER_LIVES
	Globals.respawn_player()
