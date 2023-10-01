extends EnemyBase


func _ready():
	wall_detector = $Wall_Detector
	texture = $Texture
	anime.animation_finished.connect(kill_ground_enemy)


func _physics_process(delta: float) -> void:
	_apply_gravity(delta)
	movement(delta)
	flip_direction()
