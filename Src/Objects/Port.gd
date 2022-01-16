extends Area2D


export(String,FILE) var nextScene = ""
func _on_Port_body_entered(body):
	var highScore = max(PlayerData.unlock,int(nextScene.get_basename()[-1])+1)
	var f = File.new()
	f.open(PlayerData.levelFile, File.WRITE)
	f.store_string(str(highScore))
	f.close()
	PlayerData.loadLevel()
	get_tree().change_scene(nextScene)


