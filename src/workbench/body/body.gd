extends Spatial

onready var model_cont = $Models

onready var camera = $Camera
onready var cam_pos = $CamPos

onready var xaxis_btn = $HUD/Control/MarginContainer/VBoxContainer/HBoxContainer/XAxis
onready var yaxis_btn = $HUD/Control/MarginContainer/VBoxContainer/HBoxContainer/YAxis

func _ready():
	model_cont._x_rot_active = !xaxis_btn.pressed
	model_cont._y_rot_active = !yaxis_btn.pressed

func _process(delta):
	camera.translation = lerp(camera.translation, cam_pos.translation, delta * Config.animation_speed)

func _on_XAxis_pressed():
	model_cont._x_rot_active = !xaxis_btn.pressed

func _on_YAxis_pressed():
	model_cont._y_rot_active = !yaxis_btn.pressed


func _on_ResetTransform_pressed():
	model_cont.rotation_degrees = Vector3(0, 0, 0)
#	model_cont.scale = Vector3(1, 1, 1)
	model_cont.new_scale = Vector3(1, 1, 1)
