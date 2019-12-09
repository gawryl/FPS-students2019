extends KinematicBody

func zgon():
	$AnimationPlayer.play("zgon")
	#$Timer.start()

func _on_Timer_timeout():
	queue_free()
