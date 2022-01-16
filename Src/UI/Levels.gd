extends Control



func _ready():
	for i in range($GridContainer.get_child_count()):
		PlayerData.level.append(i+1)
	for level in $GridContainer.get_children():
		if int(level.name)>PlayerData.unlock:
			level.disabled = true
		
