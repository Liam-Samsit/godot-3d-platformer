extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 12
var dir_final = 0.0
var xform : Transform3D

func _physics_process(delta: float) -> void:
	
	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	#play robot animations
	if Input.is_action_just_pressed("ui_accept") && is_on_floor():
		$AnimationPlayer.play("jump")
	elif is_on_floor() && input_dir != Vector2.ZERO:
		$AnimationPlayer.play("run")
	elif is_on_floor() && input_dir == Vector2.ZERO:
		$AnimationPlayer.play("idle")
	
	
	
	# rotate the camera left / right
	if Input.is_action_just_pressed("cam_left"):
		dir_final = dir_final + 90.0
		#$Camera_Controller.rotate_y(deg_to_rad(90))
	if Input.is_action_just_pressed("cam_right"):
		dir_final = dir_final - 90.0
		#$Camera_Controller.rotate_y(deg_to_rad(-90))
	$Camera_Controller.rotation.y = lerp($Camera_Controller.rotation.y,deg_to_rad(dir_final),0.2)
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	
	
	# it's a new vector3 direction taking into account the user arrow input and camera rotation
	var direction = ($Camera_Controller.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	# rotate the character match so teh character rotates in relation to the camera
	if input_dir != Vector2(0,0):
		$Armature.rotation_degrees.y = $Camera_Controller.rotation_degrees.y - rad_to_deg(input_dir.angle()) - 90
	
	# rotate character to align with floor, like slopes
	if is_on_floor():
		align_with_floor($RayCast3D.get_collision_normal())
		global_transform = global_transform.interpolate_with(xform,0.4)
	elif not is_on_floor():
		align_with_floor(Vector3.UP)
		global_transform = global_transform.interpolate_with(xform,0.4)
	
	# update the velocity and move the character
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		

	move_and_slide()
	# make camera controller match the position of myself
	$Camera_Controller.position = lerp($Camera_Controller.position,position,0.2)

func align_with_floor(floor_normal):
	xform = global_transform
	xform.basis.y = floor_normal
	xform.basis.x = -xform.basis.z.cross(floor_normal)
	xform.basis = xform.basis.orthonormalized()
	


func _on_fall_zone_body_entered(body: Node3D) -> void:
	get_tree().change_scene_to_file("res://level_1.tscn")
	

func bounce():
	velocity.y = JUMP_VELOCITY*2.5
	
