extends Control

signal time_is_up

@export_range(0, 5) var default_minutes := 1
@export_range(0, 59) var default_seconds := 0

var minutes = 0
var seconds = 0

@onready var timer_counter: Label = $MarginContainer/TimerHBoxContainer/TimerCounter
@onready var score_counter: Label = $MarginContainer/ScoreHBoxContainer/ScoreCounter
@onready var life_counter: Label = $MarginContainer/LifeHBoxContainer/LifeCounter
@onready var coins_counter: Label = $MarginContainer/CoinsHBoxContainer/CoinsCounter


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	coins_counter.text = str("%04d" % Globals.coins)
	score_counter.text = str("%06d" % Globals.score)
	life_counter.text = str("%02d" % Globals.player_life)
	timer_counter.text = str("%02d:%02d" % [default_minutes, default_seconds])
	reset_clock_timer()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	coins_counter.text = str("%04d" % Globals.coins)
	score_counter.text = str("%06d" % Globals.score)
	life_counter.text = str("%02d" % Globals.player_life)

	if minutes == 0 && seconds == 0:
		emit_signal("time_is_up")


func _on_timer_timeout() -> void:
	if seconds == 0 && minutes > 0:
		minutes -= 1
		seconds = 60
	seconds -= 1
	timer_counter.text = str("%02d:%02d" % [minutes, seconds])


func reset_clock_timer():
	minutes = default_minutes
	seconds = default_seconds
