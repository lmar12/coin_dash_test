extends CanvasLayer

signal start_game

func update_score(value:int) -> void:
	$MarginContainer/ScoreLabel.set_text(str(value))
func update_timer(value:int) -> void:
	$MarginContainer/TimeLabel.set_text(str(value))
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func show_message(text: String) -> void:
	$Title.set_text(text)
	$Title.show()
	$MessageTimer.start()


func _on_message_timer_timeout() -> void:
	$Title.hide()


func _on_start_button_pressed() -> void:
	$StartButton.hide()
	$Title.hide()
	emit_signal("start_game")

func show_game_over() -> void:
	show_message("Game Over")
	await get_tree().create_timer(2).timeout
	show_message("Coin Dash!")
	$StartButton.show()
	#$Title.set_text("Coin Dash!")
	$Title.show()
