extends Control

func _ready() -> void:
	SoundManager.play_menu_music()
	SoundManager.stop_level1_music()


func _on_button_pressed() -> void:
	SoundManager.play_button_sound()
	get_tree().change_scene_to_file("res://menu_title.tscn")
