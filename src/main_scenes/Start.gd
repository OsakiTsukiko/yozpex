extends Control

const wb_body = preload("res://src/workbench/body/body.tscn")

func _ready():
	pass


func _on_EnterBTN_pressed():
	get_tree().change_scene_to(wb_body)
