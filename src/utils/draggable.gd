extends Spatial
class_name Draggable

var rotating = false
var last_position = Vector2()

func _process(delta):
	if (Input.is_action_just_pressed("Rotate")):
		rotating = true
		last_position = get_viewport().get_mouse_position()
	if (Input.is_action_just_released("Rotate")):
		rotating = false

	if (rotating):
		var dif = get_viewport().get_mouse_position() - last_position
		last_position = get_viewport().get_mouse_position()
		self.rotate_y(dif.x * 1 * delta)
		self.rotate_x(dif.y * 1 * delta)
