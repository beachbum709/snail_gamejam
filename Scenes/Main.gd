extends Node2D

onready var cloud_ap = $"Geometry/Cloud animations"

func _ready():
	cloud_ap.play("Clouds")

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
