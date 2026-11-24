extends Camera3D
class_name GuidedCam3D

@export var cur_cam_guide : CamGuide = null

func _process(delta: float) -> void:
	if cur_cam_guide:
		global_transform = global_transform.interpolate_with(cur_cam_guide.global_transform,clamp(cur_cam_guide.guide_lerp_speed*delta,0.0,1.0))
	
	
