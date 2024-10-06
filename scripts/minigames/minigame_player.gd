extends Node2D

var _minigames = ["feed_cats", "clean_litter", "pet_cat", "play_with"]
var _current_game
var _games_played
var _timer

func _ready() -> void:
	_games_played = -1
	_timer = $CanvasLayer/Timer
	_switch_game()

func _process(delta: float) -> void:
	_timer.value = _current_game.timer.time_left

func _switch_game():
	_games_played += 1
	if _games_played > 0 and _games_played % 5 == 0:
		Global.speed_mult += Global.SPEED_ITER
		if Global.speed_mult >= Global.SPEED_MAX:
			Global.speed_mult = Global.SPEED_MAX
			
	var game = _minigames[randi() % _minigames.size()]
	var path = "res://scenes/minigames/%s/%s.tscn" % [game, game]
	var game_scene = load(path).instantiate()
	assert(game_scene is Minigame)
	add_child(game_scene)
	game_scene.game_won.connect(_on_minigame_win)
	game_scene.game_lost.connect(_on_minigame_loss)
	_current_game = game_scene
	_timer.max_value = _current_game.duration
	
func _on_minigame_win():
	_current_game.queue_free()
	_switch_game()

func _on_minigame_loss():
	get_tree().quit()
