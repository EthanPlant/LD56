extends Minigame

@export var wand_speed = 2000
var _wand_max
var _wand_min

func _ready() -> void:
    super()
    _wand_max = $Wand.position.y - 500
    _wand_min = $Wand.position.y + 500

func _process(delta) -> void:
    if Input.is_action_just_pressed("move_wand"):
        score += 1
        var new_y = $Wand.position.y + (wand_speed * delta * (1 if score % 2 == 0 else -1))
        new_y = clamp(new_y, _wand_max, _wand_min)
        $Wand.position.y = new_y
    check_score()
