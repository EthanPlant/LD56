extends CharacterBody2D

func _ready() -> void:
    add_to_group("bowl")

func _process(_delta: float) -> void:
    var mouse_position = get_global_mouse_position()
    position.x = clamp(mouse_position.x, 0, get_viewport().size.x - 750)
