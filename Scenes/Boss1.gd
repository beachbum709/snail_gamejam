extends KinematicBody2D

var rng = RandomNumberGenerator.new()
onready var ap = $AnimationPlayer
onready var player = $"../Player"
var velocity = Vector2()
var gravity = 25
var speed = 15
var health = 1000
var will_fall = false
var spawn_bool = false
var is_attacking = false
var flip_bool = false
var attack_finished = false
var special_attack = false

func _ready():
	ap.play("Spawn")
	

func _process(delta):
	attack()
	animation_handler()

func _physics_process(delta):
	if velocity.y <= 700:
		velocity.y = velocity.y + gravity
		
	if not will_fall and spawn_bool and not is_attacking and not special_attack:
		velocity.x = position.direction_to(player.position).x * speed
	elif will_fall:
		pass # stop motion
	
	move_and_slide(velocity, Vector2.UP)
	


func attack():
	if is_attacking or special_attack:
		velocity.x = 0
	if attack_finished:
		is_attacking = false
		$Hitbox/Hitbox.set_deferred("disabled", true)

func animation_handler():		
	if velocity.x > 0 or velocity.x < 0:
		ap.queue("Walk")
	
	if is_attacking:
		ap.play("attack")
	
	if not ap.is_playing():
		special_attack = false
	

func _on_AnimationPlayer_animation_finished(Spawn):
	if not spawn_bool:
		if position.direction_to(player.position).x > 0:
			scale.x = -scale.x
	spawn_bool = true

func _on_Switch_area_body_entered(body):
	if body.is_in_group("Player"):
		scale.x = -scale.x


func _on_Hitbox_body_entered(body):
	if body.is_in_group("Player"):
		player.velocity.y = -1500
		player.velocity.x = -1500



func _on_front_Detection_body_entered(body):
	if spawn_bool and body.is_in_group("Player"):
		if not special_attack:
			attack_finished = false
			is_attacking = true
func _on_front_Detection_body_exited(body):
	if spawn_bool and body.is_in_group("Player"):
		if not special_attack:
			$Timers/attack1_finished.start()




func _on_Attack2_detection_body_entered(body):
	if spawn_bool:
		var random = rng.randf_range(0,4)
		if random > 3:
			is_attacking = false
			special_attack = true
			ap.play("Attack2")


func _on_Particle_hitbox_body_entered(body):
	if body.is_in_group("Player"):
		player.velocity.y = -4000
		player.velocity.x = -4000


func _on_attack1_finished_timeout():
	attack_finished = true
