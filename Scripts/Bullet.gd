extends KinematicBody2D


var velocity = Vector2()
var speed = 2000

func _physics_process(delta):
	
	var collision_info = move_and_collide(velocity.normalized() * delta * speed)


func _on_hitbox_body_entered(body):
	if body.is_in_group("Enemy"):
		body.is_hit = true
