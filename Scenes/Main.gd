extends Node2D

onready var cloud_ap = $"Geometry/Cloud animations"

func _ready():
	cloud_ap.play("Clouds")

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()





#Camera switching logic
func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		$"Cameras/2".current = true
func _on_Area2D_body_exited(body):
	if body.is_in_group("Player"):
		$"Cameras/1".current = true
