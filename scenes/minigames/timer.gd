extends Sprite2D

var value: float

signal explosion_finished

func start_timer(duration):
    $AnimationPlayer.speed_scale = 1 / duration
    $AnimationPlayer.play("countdown")
    frame = 0

func explosion():
    $AnimationPlayer.speed_scale = 1
    $AnimationPlayer.play("explosion")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
    if anim_name == "explosion":
        explosion_finished.emit()

