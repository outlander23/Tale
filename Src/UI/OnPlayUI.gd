extends Control

onready var sceneTree = get_tree()
onready var sceneOverlay = get_node("pused")
onready var score: Label = get_node("score")
onready var score2: Label = get_node("score2")
onready var PausedLabel = get_node("pused/labelOnPlay")
var paused := false setget setPaused
const diedText = "You Died"

func _ready():
	PlayerData.connect("update",self,"updateInterface")
	PlayerData.connect("updateHighScore",self,"updateInterface")
	PlayerData.connect("died",self,"onPlayerDied")
	updateInterface()
func onPlayerDied():
	self.paused = true
	PausedLabel.text = diedText
	
	
func _unhandled_input(event):
	if event.is_action_pressed("pause") and PausedLabel.text !=diedText:
		self.paused = not paused
		sceneTree.set_input_as_handled()

func setPaused(value):
	paused = value
	sceneTree.paused = value
	sceneOverlay.visible = value
	
func updateInterface():
	score.text = "SCORE: %s" % PlayerData.score
	score2.text = "BEST SCORE: %s" % max(PlayerData.highScore,PlayerData.high)

func _on_replay_button_up():
	get_tree().paused = false
	get_tree().current_scene
