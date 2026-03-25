extends Area2D

@export var SPEED: int
var velocity: Vector2 = Vector2()

#These initial values are only for test purposes
var screensize: Vector2 = Vector2()
#Some signals for the game
signal pickup             #Used for the coins, and other collectables
signal hurt               #When the player gets hurted by an obstacle
signal power_up
func _ready() -> void:
	set_process(false)

func set_screensize(new: Vector2) -> void:
	screensize = new

func start(init_position: Vector2) -> void:
	position = init_position
	$AnimatedSprite2D.set_animation("idle")
	set_process(true)

func die() -> void:
	$AnimatedSprite2D.set_animation("hurt")
	set_process(false)

func get_input() -> Vector2:
	var new_velocity: Vector2 = Vector2()
	new_velocity.x = Input.get_axis("LEFT","RIGHT")
	new_velocity.y = Input.get_axis("UP","DOWN")
	return new_velocity.normalized()

func move_player(vel: Vector2, spd: float, delta: float):
	position += vel * delta * spd
	position.x = clamp(position.x,0,screensize.x)
	position.y = clamp(position.y,0,screensize.y)

func update_anim(vel: Vector2) -> void:
	#Check if the player is moving
	if velocity.length() > 0:
		$AnimatedSprite2D.set_animation("run")
	else:
		$AnimatedSprite2D.set_animation("idle")
	#Check the player x direction
	if velocity.x < 0:
		$AnimatedSprite2D.set_flip_h(true)
	if velocity.x > 0:
		$AnimatedSprite2D.set_flip_h(false)

func _process(delta: float) -> void:
	velocity = get_input()
	update_anim(velocity)
	
	move_player(velocity,SPEED,delta)


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("coin"):
		emit_signal("pickup", "coins")
	if area.is_in_group("obstacles"):
		emit_signal("hurt")
		die()
	if area.is_in_group("power_up"):
		emit_signal("pickup","power_up")
