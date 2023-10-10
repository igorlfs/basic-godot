extends CharacterBody2D

const BOX_PIECES = preload("res://prefabs/box_pieces.tscn")
const COIN_INSTANCE = preload("res://prefabs/coin_rigid.tscn")
const IMPULSE := 50

@export var pieces: PackedStringArray
@export var hit_points := 3

@onready var animation_player := $Animation as AnimationPlayer
@onready var spawn_coin = $Spawn_Coin as Marker2D
@onready var hit_block_sfx: AudioStreamPlayer = $AudioStreamPlayer


func break_sprite():
	for i in pieces.size():
		var piece = BOX_PIECES.instantiate()
		get_parent().add_child(piece)
		piece.get_node("Texture").texture = load(pieces[i])
		piece.global_position = global_position
		piece.apply_impulse(
			Vector2(randi_range(-IMPULSE, IMPULSE), randi_range(2 * -IMPULSE, -IMPULSE))
		)
	queue_free()


func create_coin():
	var coin = COIN_INSTANCE.instantiate()
	get_parent().call_deferred("add_child", coin)
	coin.global_position = spawn_coin.global_position
	coin.apply_impulse(Vector2(randi_range(-50, 50), -150))
