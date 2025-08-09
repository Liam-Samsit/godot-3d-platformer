extends Area3D

const SPEED = 2 # the number of degrees the coin rotates every frame
@export var hud : CanvasLayer
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
	SoundManager.play_coin_sound()
	$AnimationPlayer.play("bounce")
	set_collision_layer_value(3,false)
	set_collision_mask_value(1,false)
	Global.coins += 1
	hud.get_node("CoinsLabel").text = str(Global.coins) + "/" + str(Global.COINS_TO_WIN)
	if Global.coins >= Global.COINS_TO_WIN:
		get_tree().change_scene_to_file("res://menu_win.tscn")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
