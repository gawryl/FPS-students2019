extends StaticBody



func _on_Area_body_entered(body):
	print("terytorium klucza ", name)
	queue_free()

func _on_Area_body_exited(body):
	print("opuszczam terytorium klucza ", name)
