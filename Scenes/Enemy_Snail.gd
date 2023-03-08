extends KinematicBody2D

onready var ap = $AnimationPlayer
var velocity = Vector2()
const gravity = 5

func _ready():
	$CollisionShape2D/Sprite.visible = false
	ap.play("spawn")
	
func _physics_process(delta):
	if velocity.y <= 200:
		velocity.y = velocity.y + gravity
	move_and_slide(velocity,Vector2.UP)
