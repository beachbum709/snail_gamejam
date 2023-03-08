extends KinematicBody2D


var is_hit = false
var dying = false
var velocity = Vector2()
const gravity = 5
var snail = preload("res://Scenes/Enemy_Snail.tscn")
onready var ap = $AnimationPlayer

func _ready():
	$CollisionShape2D/Sprite1.visible = true

func _process(delta):
	if is_hit:
		ap.play("die")
		is_hit = false
		var snail_instance = snail.instance()
		get_parent().add_child(snail_instance)
		snail_instance.position = $CollisionShape2D.global_position

func _physics_process(delta):
	if velocity.y <= 200:
		velocity.y = velocity.y + gravity
	move_and_slide(velocity,Vector2.UP)

func _on_AnimationPlayer_animation_finished(die):
	queue_free()
