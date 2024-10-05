extends Node2D

var _minigames = ["feed_cats", "clean_litter"]

func _ready() -> void:
    var game = _minigames[randi() % _minigames.size()]
    var path = "res://scenes/minigames/%s/%s.tscn" % [game, game]
    var game_scene = load(path).instantiate()
    add_child(game_scene)
