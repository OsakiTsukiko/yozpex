extends Spatial
class_name Interactable

var is_rotating = false # GD4 doesnt like the keyword rotating
var last_position = Vector2()
var new_scale: Vector3 = scale

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
	
	if (new_scale.x < 0 || new_scale.y < 0 || new_scale.z < 0):
		new_scale = Vector3.ZERO
	scale = lerp(scale, new_scale, .1)

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			# zoom in
			if event.button_index == BUTTON_WHEEL_UP:
				new_scale = Vector3(scale.x + Config.zoom_const, scale.y + Config.zoom_const, scale.z + Config.zoom_const)
				# call the zoom function
			# zoom out
			if event.button_index == BUTTON_WHEEL_DOWN:
				new_scale = Vector3(scale.x - Config.zoom_const, scale.y - Config.zoom_const, scale.z - Config.zoom_const)
				# call the zoom function
