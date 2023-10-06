extends CanvasLayer

@onready var resume_button: Button = $VBoxContainer/Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		visible = true
		get_tree().paused = true
		resume_button.grab_focus()


func _on_button_pressed() -> void:
	get_tree().paused = false
	self.visible = false


func _on_button_2_pressed() -> void:
	get_tree().quit()
