extends Actors

export var stompImpulse=1000.0

onready var animatedPlayer =get_node("AnimatedSprite")


func _on_enemyDetector_body_entered(body):
	die()
func _on_playerKiller_area_entered(area):
	die()
func _on_playerKiller_body_exited(body):
	die()
func _on_stompDetector_area_entered(area):
	velocity.y = -2000

func _physics_process(delta):
	var direction = getDirection()
	var isJumpInterrupted = Input.is_action_just_released("jump") and  velocity.y <0.0
	velocity = callculateMoveVelocity(velocity,direction,speed,isJumpInterrupted)
	velocity.y = move_and_slide(velocity,floorNormal).y
	
func getDirection():
	var moveLeft = Input.get_action_strength("moveLeft")
	var moveRight = Input.get_action_strength("moveRight")
	var fall = velocity.y >0
	var jump = velocity.y<0
	playAnimation(moveLeft, moveRight, fall, jump)
	return Vector2(
		moveRight-moveLeft,
		-Input.get_action_strength("jump") if Input.is_action_just_pressed("jump") and is_on_floor() else 0.0
	)

func callculateMoveVelocity(velocity,direction,speed,isJumpInterrupted):
	var newVelocity = velocity
	newVelocity.x = speed.x * direction.x 
	newVelocity.y += gravity*get_process_delta_time()
	if direction.y == -1.0:
		newVelocity.y = speed.y * direction.y
	if isJumpInterrupted:
		newVelocity.y = 0.0
	return newVelocity
	

func playAnimation(moveLeft,moveRight,fall,jump):
	if fall:
		animatedPlayer.play("fall")
	elif jump:
		animatedPlayer.play("jump")
	elif moveLeft and moveRight:
		animatedPlayer.play("idel")
	elif moveRight:
		animatedPlayer.play("run")
		animatedPlayer.set_flip_h(false)
	elif moveLeft:
		animatedPlayer.play("run")
		animatedPlayer.set_flip_h(true)
	else:
		animatedPlayer.play("idel")



func calculateStompVelocity(velocity,impulse):
	var out = velocity
	out.y = -impulse
	return out

func die():
	saveScore()
	PlayerData.deaths+=1
	PlayerData.score =0
	queue_free()

var scoreFile = 'res://Src/Autoload/score.txt'

func saveScore():
	var highScore = max(PlayerData.high,PlayerData.highScore)
	print(highScore)	
	var f = File.new()
	f.open(scoreFile, File.WRITE)
	f.store_string(str(highScore))
	f.close()


func _on_playerKiller_body_entered(body):
	die()
