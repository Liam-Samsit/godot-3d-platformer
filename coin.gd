extends Area3D

const SPEED = 2 # the number of degrees the coin rotates every frame
var bop = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotate_y(deg_to_rad(SPEED))
	position.y =  position.y + sin(bop)*0.01
	bop = bop + 0.05

func _on_body_entered(body: Node3D) -> void:
	$AnimationPlayer.play("bounce")
	set_collision_layer_value(3,false)
	set_collision_mask_value(1,false)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
