extends AnimatedSprite

func _ready():
	frame = 0


func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		body.win_condition = true
		queue_free()
