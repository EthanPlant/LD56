class_name Minigame
extends Node2D

signal game_won
signal game_lost

@export var duration = 5.0
@export var threshold = 5.0
@export var prompt: String
@export var hint: String
var score
var timer

func _ready() -> void:
    score = 0
    timer = Timer.new()
    timer.wait_time = duration / Global.speed_mult
    timer.timeout.connect(_on_timer_timeout)
    timer.one_shot = true
    add_child(timer)
    timer.start()

func _process(_delta: float) -> void:
    check_score()

func check_score():
    if score >= threshold:
        game_won.emit()

func _on_timer_timeout():
    game_lost.emit()
