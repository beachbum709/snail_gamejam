extends KinematicBody2D


onready var text1 = $Label
onready var text2 = $Label2

func _ready():
	text1.percent_visible = 0
	text2.percent_visible = 0

func interact():
	print("text should be appearing")
	text1.percent_visible = lerp(0,1,0.1)
