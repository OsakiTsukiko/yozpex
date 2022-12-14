extends Spatial
class_name Interactable

var _x_rot_active: bool = true
var _y_rot_active: bool = true

var is_rotating = false # GD4 doesnt like the keyword rotating
var last_position = Vector2()
var new_scale: Vector3 = scale

func _process(delta):
	if (Input.is_action_just_pressed("right_click")):
		is_rotating = true
		last_position = get_viewport().get_mouse_position()
	if (Input.is_action_just_released("right_click")):
		is_rotating = false

	if (is_rotating):
		var dif = get_viewport().get_mouse_position() - last_position
		last_position = get_viewport().get_mouse_position()
		if (_y_rot_active): 
			self.rotate_y(dif.x * Config.state.interact_speed * delta)
		if (_x_rot_active):
			self.rotate_x(dif.y * Config.state.interact_speed * delta)
	
	if (new_scale.x < 0 || new_scale.y < 0 || new_scale.z < 0):
		new_scale = Vector3.ZERO
	scale = lerp(scale, new_scale, .1)

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			# zoom out
			if event.button_index == BUTTON_WHEEL_DOWN:
				new_scale = Vector3(scale.x * Config.state.zoom_const, scale.y * Config.state.zoom_const, scale.z * Config.state.zoom_const)
			
			# zoom in
			if event.button_index == BUTTON_WHEEL_UP:
				new_scale = Vector3(scale.x * 1/Config.state.zoom_const, scale.y * 1/Config.state.zoom_const, scale.z * 1/Config.state.zoom_const)
