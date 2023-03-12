extends Node2D

const boss1 = preload("res://Scenes/Boss1.tscn")
var spawn_bool = true
onready var player = $"Player"

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()


func _on_Area2D_body_entered(body):
	if body.is_in_group("Player") and spawn_bool:
		spawn_bool = false
		var boss_instance = boss1.instance()
		add_child(boss_instance)
		boss_instance.position = $Geometry/Boss1map/Area2D/CollisionShape2D.global_position + Vector2(0,-100)
		


func _on_Player_respawner_body_entered(body):
	if body.is_in_group("Player"):
		$Geometry/Player_respawner/Respawn_timer.start()


func _on_Respawn_timer_timeout():
	player.global_position = Vector2(350,-1248.97)
