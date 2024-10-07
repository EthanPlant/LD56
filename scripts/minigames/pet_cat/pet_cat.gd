extends Minigame

var hand_speed = 2000 * Global.speed_mult
var _hand_dir = 0
var _last_hand_dir = 0

func game_state(delta):
	if Input.is_action_just_pressed("ui_right") and _last_hand_dir != 1:
		_hand_dir = 1
		_last_hand_dir = 1
		score += 1
	elif Input.is_action_just_pressed("ui_left") and _last_hand_dir != -1:
		_hand_dir = -1
		_last_hand_dir = -1
		score += 1
	else:
		_hand_dir = 0

	$Hand.position.x += hand_speed * delta * _hand_dir
	check_score()