extends Node

const NUM_PLAYER_LIVES := 3

var coins := 0
var score := 0
var player_life := NUM_PLAYER_LIVES

var player = null
var current_checkpoint = null


func respawn_player():
	if current_checkpoint != null:
		player.position = current_checkpoint.global_position
