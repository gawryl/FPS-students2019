extends StaticBody

func _on_Area_body_entered(body):
	print("terytorium klucza ", name)
	#najpierw
	#queue_free()
	
	#potem
	if not $AudioStreamPlayer2D.is_playing():
		$AudioStreamPlayer2D.play()
		$CollisionShape.disabled = true
		yield(get_tree().create_timer(1), "timeout")
		#inne uzycie yield-a:
		#yield($AnimationPlayer, "animation_finished")
		queue_free()

func _on_Area_body_exited(body):
	print("opuszczam terytorium klucza ", name)
