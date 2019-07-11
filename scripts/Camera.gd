extends Camera

onready var player = get_tree().get_root().get_node("Scene/Player")

func _process(delta):
	transform.origin = player.transform.origin + 4 * Vector3.UP + 4 * Vector3.BACK
	look_at(player.transform.origin, Vector3.UP)
