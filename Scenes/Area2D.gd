extends Area2D



func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		var current_camera = get_parent()
		current_camera.current = true


func _on_Area2D_body_exited(body):
	if body.is_in_group("Player"):
		var current_camera = get_parent()
		current_camera.current = false

