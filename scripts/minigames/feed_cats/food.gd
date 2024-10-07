extends CharacterBody2D

@export var speed: float = 300 * Global.speed_mult
var _did_collide: bool

func _ready() -> void:
	_did_collide = false 

func _process(delta: float) -> void:
	position.y += speed * delta

	if position.y > get_viewport().size.y:
		queue_free()
		get_parent().score -= 1

func _on_body_entered(body):
	if body.is_in_group("bowl") and not _did_collide:
		get_parent().score += 1
		_did_collide = true
		queue_free()
