extends AnimatedSprite2D

var _max_value: float
var value: float

func start_timer(duration):
    _max_value = duration
    animation = "countdown"
    frame = 0

func _process(_delta: float) -> void:
    if value > 0:
        var proportion = value / _max_value
        var index = int((1 - proportion) * 5)
        frame = index
    else:
        play("explosion")