extends Spatial

onready var model_cont = $Models
onready var legend_node = $HUD/Control/MarginContainer/VBoxContainer/HSplitContainer/Legend

onready var camera = $Camera
onready var cam_pos_f = $CamPosF
onready var cam_pos_l = $CamPosL

onready var xaxis_btn = $HUD/Control/MarginContainer/VBoxContainer/HBoxContainer/XAxis
onready var yaxis_btn = $HUD/Control/MarginContainer/VBoxContainer/HBoxContainer/YAxis
onready var legend_btn = $HUD/Control/MarginContainer/VBoxContainer/HBoxContainer/Legend

var cam_pos: Position3D

var legend: Utils.Segment

func get_legend_tree_r(node: Node):
	var seg = Utils.Segment.new(node)
	for child in node.get_children():
		if (child.is_in_group("segment")):
			seg.children.append(get_legend_tree_r(child))
	return seg

func print_legend_tree(seg: Utils.Segment, prefix: String = ""):
	print(prefix + seg.name)
	for child in seg.children:
		print_legend_tree(child, prefix + "-")

func _ready():
	if (Config.state.workbench.body.is_legend_open):
		legend_node.visible = true
		cam_pos = cam_pos_l
	else:
		legend_node.visible = false
		cam_pos = cam_pos_f
	model_cont._x_rot_active = !xaxis_btn.pressed
	model_cont._y_rot_active = !yaxis_btn.pressed
	legend = get_legend_tree_r(model_cont)
	print_legend_tree(legend)

func _process(delta):
	camera.translation = lerp(camera.translation, cam_pos.translation, delta * Config.state.animation_speed)

func _on_XAxis_pressed():
	model_cont._x_rot_active = !xaxis_btn.pressed

func _on_YAxis_pressed():
	model_cont._y_rot_active = !yaxis_btn.pressed

func _on_ResetTransform_pressed():
	model_cont.rotation_degrees = Vector3(0, 0, 0)
#	model_cont.scale = Vector3(1, 1, 1)
	model_cont.new_scale = Vector3(1, 1, 1)


func _on_Legend_pressed():
	if (legend_btn.pressed):
		legend_node.visible = true
		cam_pos = cam_pos_l
		Config.state.workbench.body.is_legend_open = true
	else:
		legend_node.visible = false
		cam_pos = cam_pos_f
		Config.state.workbench.body.is_legend_open = false
	pass
