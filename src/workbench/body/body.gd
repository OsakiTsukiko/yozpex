extends Spatial

export (Texture) var viz_true_icon
export (Texture) var viz_false_icon

onready var model_cont = $Models
onready var legend_node = $HUD/Control/MarginContainer/VBoxContainer/HSplitContainer/Legend
onready var model_tree = $HUD/Control/MarginContainer/VBoxContainer/HSplitContainer/Legend/HBoxContainer/Content/MarginContainer/Tree

onready var camera = $Camera
onready var cam_pos_f = $CamPosF
onready var cam_pos_l = $CamPosL

onready var xaxis_btn = $HUD/Control/MarginContainer/VBoxContainer/HBoxContainer/XAxis
onready var yaxis_btn = $HUD/Control/MarginContainer/VBoxContainer/HBoxContainer/YAxis
onready var legend_btn = $HUD/Control/MarginContainer/VBoxContainer/HBoxContainer/Legend

var cam_pos: Position3D

var legend: Utils.Segment
var legend_array = []

func get_legend_tree_r(node: Node):
	var seg = Utils.Segment.new(node)
	legend_array.append(seg)
	for child in node.get_children():
		if (child.is_in_group("segment")):
			seg.children.append(get_legend_tree_r(child))
	return seg

func render_legend_tree(seg: Utils.Segment, parent: TreeItem = null):
	var branch: TreeItem
	if (parent == null):
		branch = model_tree.create_item()
	else:
		branch = model_tree.create_item(parent)
	branch.set_text(0, seg.name)
	if (seg.visibility):
		branch.add_button(0, viz_true_icon)
	else:
		branch.add_button(0, viz_false_icon)
	seg.tree_item_node = branch
	
	for child in seg.children:
		render_legend_tree(child, branch)

func find_in_legend_by_ti(item: TreeItem) -> Utils.Segment:
	for seg in legend_array:
		if (seg.tree_item_node == item):
			return seg
	return null

func _ready():
	if (Config.state.workbench.body.is_legend_open):
		legend_node.visible = true
		legend_btn.pressed = true
		cam_pos = cam_pos_l
	else:
		legend_node.visible = false
		legend_btn.pressed = false
		cam_pos = cam_pos_f
	model_cont._x_rot_active = !xaxis_btn.pressed
	model_cont._y_rot_active = !yaxis_btn.pressed
	legend = get_legend_tree_r(model_cont)
	render_legend_tree(legend)
	

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


func _on_Tree_button_pressed(item: TreeItem, column, id):
	var seg: Utils.Segment = find_in_legend_by_ti(item)
	# I HATE THIS
	# THIS IS SOO BAD
	# TREE BUTTONS ARE BAD BY DEFAULT!
	seg.visibility = !seg.visibility
	seg.node.visible = seg.visibility
	if (seg.visibility):
		item.set_button(column, id, viz_true_icon)
	else:
		item.set_button(column, id, viz_false_icon)
