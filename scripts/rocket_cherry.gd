extends EnemyBase

@onready var marker_2d: Marker2D = $"../Marker2D"


func _ready() -> void:
	spawn_instance = preload("res://actors/cherry.tscn")
	spawn_instance_position = marker_2d
	can_spawn = true
	anime.animation_finished.connect(kill_air_enemy)
