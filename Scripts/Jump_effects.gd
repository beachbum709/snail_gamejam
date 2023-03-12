extends AnimatedSprite

onready var ap = $AnimationPlayer

func _ready():
	visible = true
	frame = 0
	ap.play("spawn")



func _on_AnimationPlayer_animation_finished(spawn):
	queue_free()
