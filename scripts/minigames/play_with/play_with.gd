extends Minigame

var _wand_speed = 2000 * Global.speed_mult
var _wand_dir

func _ready() -> void:
	super()
	_wand_dir = 0

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("move_wand"):
		score += 1
		_wand_dir = 1 if score % 2 == 0 else -1

func game_state(delta):
	$Wand.position.y += _wand_speed * delta * _wand_dir
	_wand_dir = 0
	check_score()
