extends Node

@export var coin: PackedScene
@export var power_up: PackedScene
@export var play_time: int

var level : int
var score : int 
var time_left : int 
var screen_size: Vector2
var playing: bool = false

func _ready() -> void:
	randomize()
	screen_size = get_viewport().get_visible_rect().size
	$Player.set_screensize(screen_size)
	$Player.hide()
	
	#new_game()


func new_game() -> void:
	playing = true
	score = 0
	level = 1
	time_left = play_time
	$Player.start($PlayerStart.get_position())
	$Player.show()
	$GameTimer.start()
	$CoinContainer.spawn_coins(level,screen_size)
	$UI.update_score(score)
	$UI.update_timer(time_left)
	if not $Sounds/Music.playing:
		$Sounds/Music.play()
func _process(delta: float) -> void:
	if playing and ($CoinContainer.remaining_coins() == 0):
		new_level()
		$PowerUpTimer.set_wait_time(randf_range(5,10))
		$PowerUpTimer.start()

func new_level() -> void:
	level += 1
	time_left += 5
	$CoinContainer.spawn_coins(level,screen_size)
	$Sounds/Level.play()


func _on_game_timer_timeout() -> void:
	time_left -= 1
	$UI.update_timer(time_left)
	if time_left <= 0:
		game_over()


func _on_player_hurt() -> void:
	game_over()


func _on_player_pickup(type) -> void:
	match type:
		"coins":
			score += 1
			$Sounds/Coin.play()
			$UI.update_score(score)
		"power_up":
			time_left += 5
			$Sounds/Powerup.play()
			$UI.update_timer(time_left)

func game_over():
	$Sounds/Hit.play()
	playing = false
	$GameTimer.stop()
	for coin in $CoinContainer.get_children():
		coin.queue_free()
	$UI.show_game_over()
	$Player.die()
	


func _on_power_up_timer_timeout() -> void:
	var p = power_up.instantiate()
	p.position = Vector2(randi_range(0,screen_size.x),randi_range(0,screen_size.y))
	add_child(p)
	
