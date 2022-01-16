extends KinematicBody2D
export var speed = Vector2(300.0,3500.0)
export var velocity = Vector2.ZERO
const floorNormal = Vector2.UP

func _ready():
	set_physics_process(false)
	velocity.x = -speed.x
	velocity.y = speed.y

func _physics_process(delta):
	velocity.x *= -1 if is_on_wall() else 1
	velocity.y=move_and_slide(velocity,floorNormal).y

func die():
	get_node("CollisionShape2D").disabled = true
	queue_free()


func _on_stompDetector_body_entered(body):
	if body.global_position.y > get_node("stompDetector").global_position.y:
		return
	die()
