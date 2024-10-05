extends Minigame

@export var wand_speed = 500
var _score
var _wand_max
var _wand_min

func _ready() -> void:
    super()
    _score = 0
    _wand_max = $Wand.position.y - 500
    _wand_min = $Wand.position.y + 500

func _process(delta) -> void:
    if Input.is_action_just_pressed("ui_accept"):
        _score += 1
        var new_y = $Wand.position.y + (wand_speed * delta * (1 if _score % 2 == 0 else -1))
        new_y = clamp(new_y, _wand_max, _wand_min)
        $Wand.position.y = new_y
