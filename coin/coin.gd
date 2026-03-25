extends Area2D
const DEFAULT_SCALE : Vector2 = Vector2(0.25,0.25)
func _ready() -> void:
	pass
func pickup() -> void:
	var new_tween: Tween = create_tween()
	new_tween.set_parallel(true)
	new_tween.tween_property(self,"scale",scale+Vector2(0.3,0.3),0.3)
	new_tween.tween_property(self,"modulate:a",0,0.2)
	new_tween.connect("finished", Callable(self, "delete_coin"))
	
func delete_coin() -> void:
	queue_free()
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		set_monitoring(false)
		pickup()

func random_position(clamp: Vector2) -> void:
	position = Vector2(randi_range(0,clamp.x),
					   randi_range(0,clamp.y))
