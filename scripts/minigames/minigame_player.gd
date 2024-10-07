extends Node2D

var _minigames = ["feed_cats", "play_with", "clean_litter", "pet_cat"]
var _current_game
var _prev_game
var _games_played
var _lives
var _score

func _ready() -> void:
	_lives = 3
	_score = 0
	_games_played = -1
	_prev_game = ""
	_switch_game()
	$Timer.explosion_finished.connect(_on_explosion_finished)

func _process(_delta: float) -> void:
	if _current_game.state == Minigame.State.PLAYING:
		$Timer.value = _current_game.timer.time_left

func _switch_game():
	_games_played += 1
	if _games_played > 0 and _games_played % 5 == 0:
		Global.speed_mult += Global.SPEED_ITER
		Global.speed_mult = min(Global.speed_mult, Global.SPEED_MAX)
	
	var game = _pick_game()
	_prev_game = game
	_load_game(game)

	$Prompt.text = _current_game.prompt
	$Hint.text = _current_game.hint

	$Prompt.visible = true
	$Hint.visible = true

	
func _pick_game():
	var game
	while true:
		game = _minigames[randi() % _minigames.size()]
		if game != _prev_game:
			break
	
	return game

func _load_game(game):
	var path = "res://scenes/minigames/%s/%s.tscn"%[game, game]
	var scene = load(path).instantiate()
	assert(scene is Minigame)
	_current_game = scene
	_current_game.game_start.connect(_on_minigame_start)
	_current_game.game_won.connect(_on_minigame_win)
	_current_game.game_lost.connect(_on_minigame_loss)
	add_child(scene)

func _on_minigame_start():
	$Timer.start_timer(_current_game.duration)
	$Prompt.visible = false
	$Timer.visible = true

func _on_minigame_win():
	_score += 1
	$Score.text = "Score: %d"%_score
	_switch_game()
	$Hint.visible = false
	$Timer.visible = false

func _on_minigame_loss():
	_lives -= 1
	$Hint.visible = false
	$Timer.explosion()
	if _lives <= 0:
		get_tree().quit()
	else:
		get_node("Life%d"%(_lives + 1)).visible = false

func _on_explosion_finished():
	_current_game.queue_free()
	$Timer.visible = false
	_switch_game()