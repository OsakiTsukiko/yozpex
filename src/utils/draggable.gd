extends Spatial
class_name Draggable

var is_rotating = false # GD4 doesnt like the keyword rotating
var last_position = Vector2()

func _process(delta):
	if (Input.is_action_just_pressed("Rotate")):
		is_rotating = true
		last_position = get_viewport().get_mouse_position()
	if (Input.is_action_just_released("Rotate")):
		is_rotating = false

	if (is_rotating):
		var dif = get_viewport().get_mouse_position() - last_position
		last_position = get_viewport().get_mouse_position()
		self.rotate_y(dif.x * 1 * delta)
		self.rotate_x(dif.y * 1 * delta)
