extends Node3D
class_name CamGuide

@export var tags : Array[StringName]
@export var guide_lerp_speed : float = 6.0


func _ready() -> void:
	add_to_group("cam_guide")
