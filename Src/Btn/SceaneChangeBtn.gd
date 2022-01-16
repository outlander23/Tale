extends Button


export(String,FILE) var nextSeen: = ""

func _on_SceaneChangeBtn_button_up():
	get_tree().paused = false
	get_tree().change_scene(nextSeen)

func _get_configuration_warning():
	return "Next seen not found" if not nextSeen else ""
