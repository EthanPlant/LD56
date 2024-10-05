extends Minigame

@export var hand_speed = 2000 * Global.speed_mult
var _hand_dir = 0

func _process(delta: float) -> void:
    if Input.is_action_just_pressed("ui_right"):
        _hand_dir = 1
        score += 1
    elif Input.is_action_just_pressed("ui_left"):
        _hand_dir = -1
        score += 1
    else:
        _hand_dir = 0

    $Hand.position.x += hand_speed * delta * _hand_dir
    check_score()
