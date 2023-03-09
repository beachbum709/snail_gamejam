extends KinematicBody2D


const gravity = 5
var is_attacking = false
var jumpforce = 200
var velocity = Vector2()
var movespeed = 150
var jump_counter = 0
var bullet_speed = 2000
var bullet = preload("res://Scenes/Bullet.tscn")

onready var ap = $AnimationPlayer



	
func _process(delta):
	animation_handler()
	jump()	

func _input(event):
	if Input.is_action_just_pressed("fire") and not is_on_floor():
		is_attacking = true
		ap.play("attack1")

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
	
	print(velocity.x)
	



func animation_handler():
	#Sprite Direction
	if velocity.x < 0 and not is_on_floor():
		$Sprite.flip_h = true
	elif velocity.x > 0 and not is_on_floor():
		$Sprite.flip_h = false
	#RUNNING
	if velocity.x < -5 and is_on_floor():
		$Sprite.flip_h = true
		ap.play("RUN")
	elif velocity.x > 5 and is_on_floor():
		$Sprite.flip_h = false
		ap.play("RUN")
	else:
		if not is_attacking:
			ap.play("IDLE")
	
	#JUMPING
	if Input.is_action_pressed("jump") and is_on_floor():
		ap.play("Jump_Charge")
	if not is_on_floor() and velocity.y >= 0 and not is_attacking:
		ap.play("Jump_FALL")
	elif not is_on_floor() and not is_attacking:
		ap.play("Jump_UP")

func jump():
	if Input.is_action_pressed("jump") and is_on_floor():
		movespeed = 0
		jump_counter += 5
	elif Input.is_action_just_released("jump") and is_on_floor():
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

#Attacking logic
func _on_Weapon_hitbox_body_entered(body):
	if body.is_in_group("Enemy"):
		body.is_hit = true
func _on_AnimationPlayer_animation_finished(attack1):
	is_attacking = false
