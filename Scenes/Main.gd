extends Node2D

var boss1 = preload("res://Scenes/Boss1.tscn")
var spawn_bool = true

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()


func _on_Area2D_body_entered(body):
	if body.is_in_group("Player") and spawn_bool:
		spawn_bool = false
		var boss_instance = boss1.instance()
		boss_instance.global_position = $Geometry/Boss1map/Area2D/CollisionShape2D.global_position
