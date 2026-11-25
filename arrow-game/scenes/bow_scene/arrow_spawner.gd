extends Node3D

@export var spawner_tags : Array[String] = []
@export var arrow_scene : PackedScene = preload("res://scenes/arrow_scene/arrow.tscn")
@export var speed : float = 10.0

func spawn_arrow(arrow_speed : float = speed):
	var cam_guide : CamGuide = CamGuide.new()
	cam_guide.position = Vector3.BACK
	cam_guide.rotation_degrees.x = 60.0
	cam_guide.guide_lerp_speed = 8.0
	cam_guide.tags = ["arrow_cam"]
	var arrow_inst : ArrowBody3D = arrow_scene.instantiate()
	arrow_inst.ready.connect(arrow_inst.add_child.bindv([cam_guide]))
	arrow_inst.ready.connect(BowGlobal.arrow_fired.emit.bindv([arrow_inst,cam_guide]))
	add_child(arrow_inst)
	arrow_inst.velocity = global_basis.y.normalized()*arrow_speed
	
	
