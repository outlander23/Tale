extends Node2D
signal update
signal died
signal updateHighScore

export(String,FILE) var scoreFile = 'res://Src/Autoload/score.data'
export(String,FILE) var levelFile = 'res://Src/Autoload/level.data'
var highScore = 0
var level =[]
var unlock=0

func loadScore():
	var f = File.new()
	if f.file_exists(scoreFile):
		f.open(scoreFile, File.READ)
		var content = f.get_as_text()
		highScore = int(content)
		f.close()
		

func loadLevel():
	var f = File.new()
	if f.file_exists(levelFile):
		f.open(levelFile, File.READ)
		var content = f.get_as_text()
		unlock = int(content)
		f.close()
		
var score = 0 setget setScore
var deaths = 0 setget setDeaths


func _ready():
	loadScore()
	loadLevel()
var high = highScore setget setHighScore

func setScore(value):
	score = value
	emit_signal("update")
	
func setHighScore(value):
	high = value
	emit_signal("updateHighScore")	
	
func setDeaths(value):
	deaths = value
	emit_signal("died")

func reset():
	score=0
	deaths=0
