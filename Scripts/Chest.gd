extends KinematicBody2D

onready var player = $"../Player"
onready var ap = $AnimationPlayer

func ready():
	$Letters.visible = false

func interact():
	if player.win_condition:
		player.win_condition = false
		player.key_sprite.visible = false
		$Letters.visible = true
		ap.play("You_Win")
		ap.play("You_Win_Letters")
		$Win_timer.start()


func _on_Win_timer_timeout():
	get_tree().quit()
