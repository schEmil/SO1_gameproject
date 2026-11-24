extends Node
@export var cam : GuidedCam3D

func _ready() -> void:
	BowGlobal.arrow_fired.connect(arrow_fired)
	BowGlobal.arrow_hit_something.connect(arrow_hit)

func arrow_fired(arrow : ArrowBody3D,cam_guide : CamGuide):
	cam.cur_cam_guide = cam_guide
	

func arrow_hit(arrow : ArrowBody3D, thing : Node3D):
	for c in arrow.get_children():
		if c is CamGuide:
			if c == cam.cur_cam_guide:
				cam.cur_cam_guide = get_bow_cam_guide()
	

func get_bow_cam_guide():
	for c :CamGuide in get_tree().get_nodes_in_group("cam_guide"):
		if c.tags.has("bow"):
			return c
