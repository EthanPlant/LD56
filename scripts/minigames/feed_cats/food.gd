extends CharacterBody2D

@export var speed = 300

func _process(delta: float) -> void:
    position.y += speed * delta

    if position.y > get_viewport().size.y:
        queue_free()

func _on_body_entered(body):
    if body.is_in_group("bowl"):
        get_parent().score += 1
        queue_free()
