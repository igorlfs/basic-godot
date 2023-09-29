extends Control

@onready var timer_counter: Label = $MarginContainer/TimerHBoxContainer/TimerCounter
@onready var score_counter: Label = $MarginContainer/ScoreHBoxContainer/ScoreCounter
@onready var life_counter: Label = $MarginContainer/LifeHBoxContainer/LifeCounter
@onready var coins_counter: Label = $MarginContainer/CoinsHBoxContainer/CoinsCounter


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	coins_counter.text = str("%04d" % Globals.coins)
	score_counter.text = str("%06d" % Globals.score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	coins_counter.text = str("%04d" % Globals.coins)
	score_counter.text = str("%06d" % Globals.score)
