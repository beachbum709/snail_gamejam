extends KinematicBody2D


const gravity = 5
var jumpforce = 200
var velocity = Vector2()
var movespeed = 150
var jump_counter = 0
var bullet_speed = 2000
var bullet = preload("res://Scenes/Bullet.tscn")


func _input(event):
	if Input.is_action_just_pressed("fire"):
		fire()

func _physics_process(delta):
	if Input.is_action_pressed("left") and is_on_floor() and not Input.is_action_pressed("right"):
		velocity.x = -movespeed
	if Input.is_action_pressed("right") and is_on_floor() and not Input.is_action_pressed("left"):
		velocity.x = movespeed
	
	move_and_slide(velocity,Vector2.UP)
	if is_on_floor():
		velocity.x = lerp(velocity.x,0,0.2)
	if velocity.y <= 200:
		velocity.y = velocity.y + gravity
	if is_on_wall():
		velocity.x = lerp(-velocity.x/3,0,0.2)
	if is_on_ceiling():
		velocity.y = 50
	#Jump Code
		
	if Input.is_action_pressed("jump") and is_on_floor():
		movespeed = 0
		jump_counter += 5
	elif Input.is_action_just_released("jump") and is_on_floor():
		jump()
		
	
	
func jump():
	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		if jump_counter >= 250:
			velocity.y = -250
			velocity.x = -250
		elif jump_counter <= 70:
			velocity.y = -70
			velocity.x = -70
		else:
			velocity.y = -jump_counter
			velocity.x = -jump_counter
	else:
		if jump_counter >= 250:
			velocity.y = -250
		elif jump_counter <= 70:
			velocity.y = -70
		else:
			velocity.y = -jump_counter
	jump_counter = 0
	movespeed = 150

func fire():
	#change this to pointing downwards
	var bullet_instance = bullet.instance()
	
	get_parent().add_child(bullet_instance)
	bullet_instance.position = global_position
	
	bullet_instance.velocity.y += 1
	
	
