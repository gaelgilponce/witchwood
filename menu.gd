extends Control


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://FONDO2.tscn")
	

func _on_exit_pressed():
	get_tree().quit()
