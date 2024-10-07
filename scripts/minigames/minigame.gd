class_name Minigame
extends Node2D

enum State {
	INTRO,
	PLAYING,
	WIN,
	LOSS
}

signal game_start
signal game_won
signal game_lost

@export var duration = 5.0
@export var threshold = 5.0
@export var prompt: String
@export var hint: String
var score
var state
var timer
var _has_lost
var _has_won

func _ready() -> void:
	score = 0
	state = State.INTRO
	_has_lost = false
	_has_won = false

	timer = Timer.new()
	timer.timeout.connect(_on_timer_timeout)
	timer.one_shot = true
	add_child(timer)
	timer.start(1.0 / Global.speed_mult)

func _process(delta: float) -> void:
	match state:
		State.INTRO:
			game_state(delta)
		State.PLAYING:
			game_state(delta)
		State.WIN:
			win_state()
		State.LOSS:
			loss_state()

func game_state(_delta):
	check_score()

func win_state():
	if not _has_won:
		game_won.emit()
		timer.stop()
		_has_won = true
		timer.paused = true

func loss_state():
	if not _has_lost:
		game_lost.emit()
		_has_lost = true

func check_score():
	if score >= threshold:
		state = State.WIN

func _on_timer_timeout():
	if state == State.INTRO:
		timer.start(duration / Global.speed_mult)
		state = State.PLAYING
		game_start.emit()
	elif state == State.PLAYING:
		state = State.LOSS
