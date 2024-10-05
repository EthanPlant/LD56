class_name Minigame
extends Node2D

signal game_won
signal game_lost

@export var duration = 5.0
@export var threshold = 5.0
var score
var _timer

func _ready() -> void:
    score = 0
    _timer = Timer.new()
    _timer.wait_time = duration / Global.speed_mult
    _timer.timeout.connect(_on_timer_timeout)
    _timer.one_shot = true
    add_child(_timer)
    _timer.start()

func _process(_delta: float) -> void:
    check_score()

func check_score():
    if score >= threshold:
        game_won.emit()

func _on_timer_timeout():
    game_lost.emit()
