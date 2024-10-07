extends Sprite2D

signal dropped(id)

@export var cat_id = -1
var _is_dragging = false

func _process(delta: float) -> void:
    if _is_dragging:
        global_position = get_global_mouse_position()

func _on_area_2d_input_event(viewport:Node, event:InputEvent, shape_idx:int) -> void:
    if Input.is_action_pressed("click"):
        _is_dragging = true 
    elif Input.is_action_just_released("click"):
        if _is_dragging:
            _is_dragging = false
            dropped.emit(cat_id)
