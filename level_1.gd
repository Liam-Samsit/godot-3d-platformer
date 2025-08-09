extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SoundManager.play_level1_music()
	Global.coins = 0
	$HUD.get_node("CoinsLabel").text = str(Global.coins) + "/" + str(Global.COINS_TO_WIN)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
