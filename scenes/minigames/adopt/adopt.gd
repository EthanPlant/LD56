extends Minigame

@onready var desired_cat = $Person/Bubble/DesiredCat
var _desired

func _ready() -> void:
    super()
    _desired = randi() % 3
    desired_cat.frame = _desired



func _on_dropped(cat_id) -> void:
    var cat
    match cat_id:
        0:
            cat = $Orange
        1:
            cat = $Grey
        2:
            cat = $Black
    
    if cat.get_node("Area2D").overlaps_area($Person/DropArea):
        if cat_id == _desired:
            state = State.WIN
        else:
            state = State.LOSS
