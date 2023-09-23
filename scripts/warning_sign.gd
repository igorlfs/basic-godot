extends Node2D

const LINES: Array[String] = [
	"Olá, mundo!", "Testando", "Frase Grandona pra ver como fica", "Colocando! Mais, Pontuação?"
]

@onready var area_sign: Area2D = $Area_Sign
@onready var texture: Sprite2D = $Texture


func _unhandled_input(event: InputEvent) -> void:
	if area_sign.get_overlapping_bodies().size() > 0:
		texture.show()
		if event.is_action_pressed("interact") && !DialogManager.is_message_active:
			texture.hide()
			DialogManager.start_message(global_position, LINES)
	else:
		texture.hide()
		if DialogManager.dialog_box != null:
			DialogManager.dialog_box.queue_free()
			DialogManager.is_message_active = false
