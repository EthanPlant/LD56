class_name Minigame
extends Node2D

signal game_won

@export var duration = 5.0
var _timer

func _ready() -> void:
    _timer = Timer.new()
    _timer.wait_time = duration
    _timer.timeout.connect(_on_timer_timeout)
    _timer.one_shot = true
    add_child(_timer)
    _timer.start()

func end_game():
    game_won.emit()

func _on_timer_timeout():
    end_game()
