extends CharacterBody2D

const BOX_PIECES = preload("res://prefabs/box_pieces.tscn")
const IMPULSE := 50

@export var pieces: PackedStringArray
@export var hit_points := 3

@onready var animation_player := $Animation as AnimationPlayer


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
