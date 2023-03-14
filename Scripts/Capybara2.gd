extends KinematicBody2D


onready var text1 = $Label
onready var text2 = $Label2

var text1_bool = true
var text1_closing_bool = false
var text2_bool = false
var text2_closing_bool = false

func _ready():
	set_process(false)
	#set_process(false)
	text1.percent_visible = 0
	text2.percent_visible = 0

func interact():
	set_process(true)
	print("interact")


func _process(delta):
	if text1_bool:
		text1.percent_visible += 0.005
		$Talking.play()
		if text1.percent_visible == 1:
			$text1timer.start()
			text1_bool = false
	elif text1_closing_bool:
		text1.percent_visible -= 0.005
		if text1.percent_visible <= 0.01:
			text1_closing_bool = false
			text2_bool = true
	if text2_bool:
		text2.percent_visible += 0.005
		$Talking.play()
		if text2.percent_visible == 1:
			$text2timer.start()	
			text2_bool = false
	elif text2_closing_bool:
		text2.percent_visible -= 0.005
		if text2.percent_visible <= 0.01:
			text2_closing_bool = false
			$texttimergeneral.start()
			


func _on_text1timer_timeout():
	text1_closing_bool = true
	


func _on_text2timer_timeout():
	text2_closing_bool = true


func _on_texttimergeneral_timeout():
	print("ready")
	set_process(false)
	text1_bool = true
