extends Minigame

func _ready():
	super()
	$TreatBag/AnimationPlayer.speed_scale = Global.speed_mult
	$TreatBag/AnimationPlayer.speed_scale = Global.speed_mult

func _on_bar_bar_hit() -> void:
	print("hi")
	score += 1
	$Treat.visible = true
	$TreatBag/AnimationPlayer.play("shake_bag")
	$Treat/AnimationPlayer.play("move_treat")



func _on_animation_player_animation_finished(anim_name:StringName) -> void:
	$Treat.visible = false
