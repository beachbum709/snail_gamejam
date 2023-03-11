extends KinematicBody2D

var is_moving_left = true
var is_attacking = false
var is_hit = false
var is_dead = false
var dying = false
var speed = 40
var velocity = Vector2()
const gravity = 10
var snail = preload("res://Scenes/Enemy_Snail.tscn")
onready var ap = $AnimationPlayer
onready var ground_check = $Groud_check

func _ready():
	$Sprite1.visible = true

func _process(delta):
	if is_hit:
		ap.stop()
		ap.play("die")
		is_dead = true
		var snail_instance = snail.instance()
		get_parent().add_child(snail_instance)
		snail_instance.position = $CollisionShape2D.global_position
		is_hit = false
	

func _physics_process(delta):
	if not is_dead:
		move_character()
		detect_turn_around()
		animation_handler()

func _on_AnimationPlayer_animation_finished(die):
	queue_free()

func move_character():
	if not is_attacking:
		velocity.x = -speed if is_moving_left else speed
	else:
		velocity.x = 0
	velocity.y += gravity
	
	velocity = move_and_slide(velocity, Vector2.UP)

func detect_turn_around():
	if not ground_check.is_colliding() and is_on_floor() or is_on_wall():
		is_moving_left = !is_moving_left
		scale.x = -scale.x
		
func animation_handler():
	if velocity.x > 0 or velocity.x < 0:
		ap.play("WALK")


func _on_Player_Detection_body_entered(body):
	if body.is_in_group("Player"):
		is_attacking = true
		if not is_dead:
			ap.play("Attack")
func _on_Player_Detection_body_exited(body):
	if body.is_in_group("Player"):
		is_attacking = false
		$"Sprite1/Attack effects".visible = false
		$Hitbox/CollisionShape2D.disabled = true


func _on_Hitbox_body_entered(body):
	if body.is_in_group("Player"):
		body.damaged = true
		if rotation_degrees <= 90:
			body.velocity.x = -500
			body.velocity.y = -500
		elif rotation_degrees >= 90:
			body.velocity.x = 500	
			body.velocity.y = -500
func _on_Hitbox_body_exited(body):
	if body.is_in_group("Player"):
		body.damaged = false
