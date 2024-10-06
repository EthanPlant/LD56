extends Node2D

var _minigames = ["feed_cats", "clean_litter", "pet_cat", "play_with"]
var _current_game
var _games_played
var _lives

func _ready() -> void:
	$PromptTimer.timeout.connect(_on_prompt_timer)
	$Timer.explosion_finished.connect(_on_explosion_finished)
	_lives = 3
	_games_played = -1
	_switch_game()

func _process(_delta: float) -> void:
	$Timer.value = _current_game.timer.time_left

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
	$Timer.start_timer(game_scene.duration)
	$PromptTimer.wait_time = 1.0 / Global.speed_mult
	$PromptTimer.one_shot = true
	$PromptTimer.start()
	$Prompt.text = _current_game.prompt
	$Prompt.visible = true
	$Hint.text = _current_game.hint
	
func _on_prompt_timer():
	$Prompt.visible = false

func _on_minigame_win():
	_current_game.queue_free()
	_switch_game()

func _on_minigame_loss():
	_lives -= 1
	if _lives <= 0:
		get_tree().quit()
	else:
		get_node("Live%d"%(_lives +1)).visible = false

func _on_explosion_finished():
	_current_game.queue_free()
	_switch_game()