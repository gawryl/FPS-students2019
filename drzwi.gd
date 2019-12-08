extends Spatial

var otwarte = false
var w_zasiegu = false

func _on_Area_body_entered(body):
	if body.name == "Stefan":
		print("stoisz przy drzwiach")
		w_zasiegu = true

func _input(event):
	if Input.is_action_just_pressed("owtorz") and w_zasiegu == true and not $AnimationPlayer.is_playing():
		if not otwarte:
			$AnimationPlayer.play("owtwieraj")
		else:
			$AnimationPlayer.play_backwards("owtwieraj")
		otwarte = not otwarte
		$AudioStreamPlayer2D.play()


func _on_Area_body_exited(body):
	w_zasiegu = false
