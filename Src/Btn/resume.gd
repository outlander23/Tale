extends Button



func _on_resume_button_up():
	PlayerData.score = 0
	get_tree().paused = false
	

