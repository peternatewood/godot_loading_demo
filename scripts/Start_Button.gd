extends Button

func _pressed():
	var loader = get_node("/root/Scene_Loader")
	loader.goto_scene("res://main.tscn")

