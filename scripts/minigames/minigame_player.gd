extends Node2D

var _minigames = ["feed_cats", "clean_litter"]
var _current_game

func _ready() -> void:
	_switch_game()

func _switch_game():
	var game = _minigames[randi() % _minigames.size()]
	var path = "res://scenes/minigames/%s/%s.tscn" % [game, game]
	var game_scene = load(path).instantiate()
	add_child(game_scene)
	game_scene.game_won.connect(_on_minigame_win)
	_current_game = game_scene

func _on_minigame_win():
	_current_game.queue_free()
	_switch_game()
