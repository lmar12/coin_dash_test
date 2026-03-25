extends Node
@export var coins: PackedScene


signal out_of_coins

func _ready() -> void:
	set_process(true)
func spawn_coins(level: int, position_clamp: Vector2) -> void:
	for i in range(4 + level):
		var c = coins.instantiate()
		c.random_position(position_clamp)
		add_child(c)
func remaining_coins() -> int:
	return get_child_count()
