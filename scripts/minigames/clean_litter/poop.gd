extends Node2D

signal clicked(name)

func _on_area_2d_input_event(_viewport:Node, _event:InputEvent, _shape_idx:int) -> void:
	if Input.is_action_just_pressed("click"):
		clicked.emit(self.name)
