extends Node2D

var rng = RandomNumberGenerator.new()
var random_cloud_position_toleft = rng.randf_range(1976, 2100)

var cloud_counter = 0
var clouds = get_children()


func _process(delta):
	var clouds = get_children()
	
	
	for cloud in clouds:
		if cloud.is_in_group("Big Cloud"):
			cloud.position.x -= 0.01
			if cloud.position.x <= 496:
				cloud.position.x = 2508.667
		if cloud.is_in_group("Little Cloud"):
			cloud.position.x -= 0.02
			if cloud.position.x <= 400:
				cloud.position.x = random_cloud_position_toleft
		if cloud.is_in_group("Tiny Cloud"):
			cloud.position.x -= 0.07
			if cloud.position.x <= 400:
				cloud.position.x = random_cloud_position_toleft

	
	
