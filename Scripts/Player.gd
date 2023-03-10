extends KinematicBody2D



const gravity = 25
var damaged
var is_attacking = false
var jumpforce = 1000
var velocity = Vector2()
var movespeed = 300
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
	if Input.is_action_pressed("left") and is_on_floor() and not Input.is_action_pressed("right") and is_on_floor() and not damaged:
		velocity.x = -movespeed
	if Input.is_action_pressed("right") and is_on_floor() and not Input.is_action_pressed("left") and is_on_floor() and not damaged:
		velocity.x = movespeed
		
	
	move_and_slide(velocity,Vector2.UP)
	if is_on_floor():
		velocity.x = lerp(velocity.x,0,0.2)
		movespeed = 300
	if velocity.y <= 400:
		velocity.y = velocity.y + gravity
	if is_on_wall():
		velocity.x = lerp(-velocity.x/3,0,0.4)
	if is_on_ceiling():
		velocity.y = gravity
	
	


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
		if not is_attacking or is_on_floor():
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
		jump_counter += 10
	elif Input.is_action_just_released("jump") and is_on_floor():
		if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
			if jump_counter >= jumpforce:
				velocity.y = -jumpforce
				movespeed = jumpforce - 200
			elif jump_counter <= 350:
				velocity.y = -350
				movespeed = 350
			else:
				velocity.y = -jump_counter
				movespeed = jump_counter - 100
		else:
			if jump_counter >= jumpforce:
				velocity.y = -jumpforce
			elif jump_counter <= 350:
				velocity.y = -350
			else:
				velocity.y = -jump_counter
		print(movespeed,velocity.y)
		jump_counter = 0

#Attacking logic
func _on_Weapon_hitbox_body_entered(body):
	if body.is_in_group("Enemy"):
		body.is_hit = true
func _on_AnimationPlayer_animation_finished(attack1):
	is_attacking = false
