extends KinematicBody2D



const gravity = 25
var damaged
var is_attacking = false
var superjump = false
var jumpforce = 1100
var velocity = Vector2()
var movespeed
var jump_counter = 0
var jump_effects = preload("res://Scenes/Jump_effects.tscn")
var landing_effects = preload("res://Scenes/Landing_effects.tscn")
var running_effects = preload("res://Scenes/Running_effects.tscn")
var run_effect_bool = false
var on_ground = false

onready var ap = $AnimationPlayer



	
func _process(delta):
	animation_handler()
	jump()	
	interaction()
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
		movespeed = 200
		if ap.current_animation == "attack1":
			ap.play("IDLE")
			$"Sprite/Weapn Effects".visible = false
			$Weapon_hitbox/CollisionShape2D.disabled = true
		if not on_ground:
			var landing_instance = landing_effects.instance()
			get_parent().add_child(landing_instance)
			landing_instance.global_position = global_position + Vector2(0,10)
		on_ground = true
	else:
		on_ground = false
		
	if velocity.y <= 600:
		velocity.y = velocity.y + gravity
	if is_on_wall():
		velocity.x = lerp(-velocity.x/3,0,0.4)
	if is_on_ceiling():
		velocity.y = gravity
	

	
	if Input.is_action_just_pressed("right"):
		$Running_effects_Timer.start()
		run_effect_bool = false
	if Input.is_action_just_pressed("left"):
		$Running_effects_Timer.start()
		run_effect_bool = true


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
		if not is_attacking and is_on_floor():
			ap.play("IDLE")
			$Running_effects_Timer.stop()
	
	#JUMPING
	if Input.is_action_pressed("jump") and is_on_floor():
		ap.play("Jump_Charge")
	if not is_on_floor() and velocity.y >= 0 and not is_attacking:
		ap.play("Jump_FALL")
	elif not is_on_floor() and not is_attacking:
		ap.play("Jump_UP")

func jump():
	jumpforce = 3000 if superjump else 1100
	if Input.is_action_pressed("jump") and is_on_floor():
		
		movespeed = 0
		jump_counter += 10
	elif Input.is_action_just_released("jump") and is_on_floor():
		var effects = jump_effects.instance()
		get_parent().add_child(effects)
		effects.global_position = global_position + Vector2(0,15)
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
		jump_counter = 0

#Attacking logic
func _on_Weapon_hitbox_body_entered(body):
	if body.is_in_group("Enemy"):
		body.is_hit = true
func _on_AnimationPlayer_animation_finished(attack1):
	is_attacking = false

func interaction():
	var collider = $Interact.get_collider()
	var collider2 = $Interact2.get_collider()
	if collider != null and collider.is_in_group("Interactable") and $Sprite/Interact2.visible == false:
		$Sprite/Interact.visible = true
		if Input.is_action_just_pressed("interact"):
			collider.interact()
	elif collider2 != null and collider2.is_in_group("Interactable") and $Sprite/Interact.visible == false:
		$Sprite/Interact2.visible = true
		if Input.is_action_just_pressed("interact"):
			collider.interact()
	else:
		$Sprite/Interact.visible = false
		$Sprite/Interact2.visible = false
	


func _on_Running_effects_Timer_timeout():
	var running_instance = running_effects.instance()
	get_parent().add_child(running_instance)
	if run_effect_bool:
		running_instance.flip_h = true
		running_instance.global_position = global_position + Vector2(10,4)
	else:
		running_instance.flip_h = false
		running_instance.global_position = global_position + Vector2(-10,4)
