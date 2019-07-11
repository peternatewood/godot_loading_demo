extends Node

const TIME_MAX: int = 10

var current_scene
var loader
var loading_bar
var wait_frames: int

func _ready():
	print("Scene_Loader ready")
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)

func _process(delta):
	if loader == null:
		set_process(false)
		return

	if wait_frames > 0:
		wait_frames -= 1
		return

	var time = OS.get_ticks_msec()
	while OS.get_ticks_msec() < time + TIME_MAX:
		var error = loader.poll()

		if error == ERR_FILE_EOF:
			print("Load complete")
			var resource = loader.get_resource()
			loader = null
			_set_new_scene(resource)
			break
		elif error == OK:
			_update_progress()
		else:
			# TODO: handle error somehow
			loader = null
			break

func _update_progress():
	var progress = float(loader.get_stage()) / loader.get_stage_count()
	print(progress)
	# TODO: set load bar position
	if loading_bar == null:
		loading_bar = get_tree().get_root().get_node("Scene/Loading Bar")

	if loading_bar != null:
		loading_bar.value = 100 * progress

func _set_new_scene(scene_resource):
	var new_scene = scene_resource.instance()
	get_tree().get_root().add_child(new_scene)

# PUBLIC

func goto_scene(path):
	loader = ResourceLoader.load_interactive("res://main.tscn")
	if loader == null:
		# TODO: handle error somehow
		return
	set_process(true)

	current_scene.queue_free()

	get_tree().change_scene("res://loading.tscn")

	loading_bar = get_tree().get_root().get_node("Scene/Container/Loading Bar")

	wait_frames = 1
	print("Load started")
