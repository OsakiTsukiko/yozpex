extends Spatial

onready var camera = $Camera
onready var cam_pos = $CamPos

func _ready():
	pass

func _process(delta):
	camera.translation = lerp(camera.translation, cam_pos.translation, delta * Config.animation_speed)
