extends Node2D

@export var poop_count = 5

var _poop_list = []

func _ready() -> void:
    var poop_scene = preload("res://scenes/minigames/clean_litter/poop.tscn")
    for i in range(poop_count):
        var poop_instance = poop_scene.instantiate()
        poop_instance.position = Vector2(randf_range(0, 600), randf_range(0, 300))
        poop_instance.name = "poop%d" % i
        poop_instance.clicked.connect(_on_poop_clicked)
        add_child(poop_instance)
        _poop_list.append(poop_instance)

func _on_poop_clicked(poop_name):
    get_node(NodePath(poop_name)).visible = false
