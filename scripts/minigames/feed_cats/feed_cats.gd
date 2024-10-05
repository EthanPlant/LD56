extends Minigame

func _ready() -> void:
    super()
    var spawn_timer = Timer.new()
    spawn_timer.wait_time = 0.5
    spawn_timer.one_shot = false
    spawn_timer.timeout.connect(_on_spawn_timer)
    add_child(spawn_timer)
    spawn_timer.start()

func _on_spawn_timer():
    _spawn_item()

func _spawn_item() -> void:
    var item_scene = preload("res://scenes/minigames/feed_cats/food.tscn")
    var item_instance = item_scene.instantiate()
    print(get_viewport().size.x)
    item_instance.position = Vector2(randf_range(0, get_viewport().get_visible_rect().size.x - 40), 0)
    print(item_instance.position)
    add_child(item_instance)
