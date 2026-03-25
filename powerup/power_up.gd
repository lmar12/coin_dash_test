extends Area2D

func _ready() -> void:
	var new_tween: Tween = create_tween()
	new_tween.tween_property(self,"modulate:a",255,1)
func _on_lifetime_timeout() -> void:
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		set_monitoring(false)
		queue_free()
