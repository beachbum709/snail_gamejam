extends KinematicBody2D

onready var ap = $AnimationPlayer

func _ready():
	$CollisionShape2D/Sprite.visible = false
	ap.play("spawn")
