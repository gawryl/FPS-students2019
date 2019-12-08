extends StaticBody

var otwarta = false
var w_zasiegu = false

#func _on_Area_body_entered(body):
#	if body.name == "Stefan":
#		print("otoczenie skrzyni ")
#		if not $"AnimationPlayer".is_playing():
#			$"AudioStreamPlayer3D".play()
#			if otwarta:
#				$"AnimationPlayer".play_backwards("open-lid")
#			else:
#				$"AnimationPlayer".play("open-lid")
#			otwarta = not otwarta

func _on_Area_body_entered(body):
	if body.name == "Stefan":
		print("otoczenie skrzyni ")
		$Sprite3D.visible = true
		w_zasiegu = true

func _on_Area_body_exited(body):
	if body.name == "Stefan":
		$Sprite3D.visible = false
		w_zasiegu = false

func otworz():
	if w_zasiegu:
		if not $"AnimationPlayer".is_playing():
			$"AudioStreamPlayer3D".play()
			if otwarta:
				$"AnimationPlayer".play_backwards("open-lid")
			else:
				$"AnimationPlayer".play("open-lid")
			otwarta = not otwarta

func _input(event):
	if Input.is_action_just_pressed("owtorz"):
		otworz()