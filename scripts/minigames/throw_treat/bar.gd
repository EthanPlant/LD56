extends Sprite2D

signal bar_hit

var _swing_speed = 75 * Global.speed_mult
var _swing_dir = 1

func _ready() -> void:
    var safe_area_x = randi_range(-21, 21)
    $SafeArea.position.x = safe_area_x
    $SafeArea.visible = true

func _process(delta):
    $Swing.position.x += _swing_speed * _swing_dir * delta
    if $Swing.position.x <= -25:
        _swing_dir = 1
    elif $Swing.position.x >= 25:
        _swing_dir = -1
    
    if Input.is_action_just_pressed("ui_accept"):
        if $Swing/Area2D.overlaps_area($SafeArea/Area2D):
            bar_hit.emit()
        else:
            get_parent().state = Minigame.State.LOSS

