extends Node2D

enum State {
	TRANSITION,
	PLAYING
}

var _minigames = ["feed_cats", "play_with", "clean_litter", "pet_cat", "throw_treats", "adopt"]
var _current_game
var _prev_game
var _lives
var _state

func _ready() -> void:
	_lives = 5
	Global.score = 0
	_prev_game = ""
	_state = State.TRANSITION
	$TransitionTimer.wait_time = 1.5
	$TransitionTimer.one_shot = true
	$TransitionTimer.start()
	$Score.text = "1"

func _process(_delta: float) -> void:
	if _state == State.TRANSITION:
		$TransitionBG.visible = true
		$Lives.update_lives(_lives)
		$Score.text = "%d"%(Global.score + 1)
	elif _state == State.PLAYING:
		if _current_game.state == Minigame.State.PLAYING:
			$Timer.value = _current_game.timer.time_left

func _switch_game():
	Global.score += 1
	
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
	$MinigameMusic.pitch_scale = Global.speed_mult
	$MinigameMusic.play()
	add_child(scene)

func _on_minigame_start():
	$Prompt.visible = false

func _on_minigame_win():
	$Score.text = "%d"%(Global.score + 1)
	$Hint.visible = false				
	$Timer.visible = false
	$MinigameMusic.stop()
	$WinSound.play()

func _on_minigame_loss():
	_lives -= 1
	$Hint.visible = false
	$Timer.visible = false
	$LossSound.play()
	$MinigameMusic.stop()

func _on_transition_timer_timeout() -> void:
	$Score.visible = false
	$Lives.visible = false
	if Global.score != 0 and Global.score % 5 == 0 and Global.speed_mult != Global.SPEED_MAX:
		$Score.visible = false
		$Lives.visible = false
		Global.speed_mult += Global.SPEED_ITER
		Global.speed_mult = min(Global.speed_mult, Global.SPEED_MAX)
		$SpeedUpTimer.start()
		$SpeedUp.visible = true
	else:
		_switch_game()
		_state = State.PLAYING

func _on_speed_up_timer_timeout():
	$SpeedUp.visible = false
	_switch_game()
	_state = State.PLAYING

func _on_sound_finished():
	$Score.visible = true
	$Lives.visible = true
	if _lives <= 0:
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
	else:
		$TransitionTimer.start()
		_state = State.TRANSITION
		_current_game.queue_free()
