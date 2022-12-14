extends HSplitContainer


func _ready():
	split_offset = Config.state.workbench.body.legend_split_offset
	pass

var org_is_grabbed = false
func _on_Resizer_gui_input(event):
	if event.is_action_pressed("left_click"):
		org_is_grabbed = true
	elif event.is_action_released("left_click"):
		org_is_grabbed = false
	
	if org_is_grabbed and event is InputEventMouseMotion:
		split_offset += event.relative.x
		Config.state.workbench.body.legend_split_offset = split_offset
