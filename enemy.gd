extends CharacterBody3D


const SPEED = 3.0
@export var direction := Vector3(1,0,0)
var turning := false

func _physics_process(delta: float) -> void:
	
	velocity.x = SPEED * direction.x
	velocity.z = SPEED * direction.z
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()
	
	if is_on_wall() && !turning:
		
		turn_around()
		
		
func turn_around():
	turning = true
	var dir = direction
	direction = Vector3(0,0,0)
	var turn_tween = create_tween()
	turn_tween.tween_property(self, "rotation_degrees", Vector3(0,180,0),0.6).as_relative()
	
	await get_tree().create_timer(0.6).timeout
	
	direction.x = -dir.x
	direction.z = -dir.z
	turning = false
