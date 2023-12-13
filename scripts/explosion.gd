extends CPUParticles2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	await get_tree().create_timer(5).timeout
	queue_free()
