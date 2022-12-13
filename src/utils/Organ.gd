extends StaticBody
class_name Organ

func _click():
	pass

func _input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton \
	and event.is_action("Click") \
	and event.is_pressed():
		_click()
