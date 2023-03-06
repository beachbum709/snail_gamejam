extends KinematicBody2D


const gravity = 5
var jumpforce = -200
var velocity = Vector2()
var movespeed = 200
var bullet_speed = 2000
var bullet = preload("res://Scenes/Bullet.tscn")


func _ready():
	pass 
	

func _physics_process(delta):
	if Input.is_action_pressed("left"):
		velocity.x = -movespeed
	if Input.is_action_pressed("right"):
		velocity.x = movespeed
	
	move_and_slide(velocity,Vector2.UP)
	velocity.x = lerp(velocity.x,0,0.2)
	
	velocity.y = velocity.y + gravity
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jumpforce
	
	
	
	$hand.look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("fire"):
		fire()
	

func fire():
	var bullet_instance = bullet.instance()
	
	get_parent().add_child(bullet_instance)
	bullet_instance.position = $hand.global_position
	
	bullet_instance.velocity = get_global_mouse_position() - bullet_instance.position
	
	
