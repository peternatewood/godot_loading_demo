extends RigidBody

var score: int = 0
var inputs: Vector3

func _physics_process(delta):
	inputs.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	inputs.z = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	apply_central_impulse(inputs)
