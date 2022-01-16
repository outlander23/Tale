extends Area2D
export var points = 100
onready var animPlayer = get_node("AnimationPlayer")


func _on_Coin_body_entered(body):
	PlayerData.score+=points
	PlayerData.high=max(PlayerData.high,PlayerData.score)
	animPlayer.play("fadeOut")
