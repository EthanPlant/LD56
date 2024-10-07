extends Node2D

enum State {
	TRANSITION,
	PLAYING
}

var _minigames = ["feed_cats", "play_with", "clean_litter", "pet_cat", "throw_treats", "adopt"]
var _current_game
var _prev_game
var _games_played
var _lives
var _state

func _ready() -> void:
	_lives = 5
	_games_played = -1
	_prev_game = ""
	_state = State.TRANSITION
	$TransitionTimer.wait_time = 1.5
	$TransitionTimer.one_shot = true
	$TransitionTimer.start()
	$Score.text = "1"

func _process(_delta: float) -> void:
	print(_state)
	if _state == State.TRANSITION:
		$TransitionBG.visible = true
		$Lives.visible = true
		$Score.visible = true
		$Lives.update_lives(_lives)
	elif _state == State.PLAYING:
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

	$Timer.max_value = _current_game.duration / Global.speed_mult
	$Timer.value = _current_game.duration / Global.speed_mult
	$Timer/AnimatedSprite2D.speed_scale = Global.speed_mult
	$Timer.visible = true

	$Prompt.text = _current_game.prompt
	$Hint.text = _current_game.hint

	$Prompt.visible = true
	$Hint.visible = true

	$Score.visible = false
	$Lives.visible = false

	
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
	$Prompt.visible = false

func _on_minigame_win():
	$Score.text = "%d"%(_games_played + 2)
	$Hint.visible = false
	$Timer.visible = false
	_state = State.TRANSITION
	_current_game.queue_free()
	$TransitionTimer.start()

func _on_minigame_loss():
	_lives -= 1
	$Hint.visible = false
	$Timer.visible = false
	if _lives <= 0:
		get_tree().quit()
	else:
		$TransitionTimer.start()
		_state = State.TRANSITION
		_current_game.queue_free()

func _on_transition_timer_timeout() -> void:
	$Score.visible = false
	$Hint.visible = false
	_switch_game()
	_state = State.PLAYING
