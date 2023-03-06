extends KinematicBody2D


var is_hit = false
var snail = preload("res://Scenes/Enemy_Snail.tscn")

func _process(delta):
	if is_hit:
		var snail_instance = snail.instance()
		get_parent().add_child(snail_instance)
		snail_instance.position = $CollisionShape2D.global_position
		queue_free()
