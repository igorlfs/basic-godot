extends EnemyBase


func _ready():
	anime.animation_finished.connect(kill_air_enemy)


func _physics_process(delta: float) -> void:
	_apply_gravity(delta)
	movement(delta)
