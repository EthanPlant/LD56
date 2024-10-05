extends CharacterBody2D

func _ready() -> void:
    add_to_group("bowl")

func _process(_delta: float) -> void:
    var mouse_position = get_global_mouse_position()
    position.x = clamp(mouse_position.x, $Sprite2D.texture.get_width() / 2, get_viewport_rect().size.x - $Sprite2D.texture.get_width() / 2)
