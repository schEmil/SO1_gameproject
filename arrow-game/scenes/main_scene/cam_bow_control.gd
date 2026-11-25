extends Node
@export var cam : GuidedCam3D
@export var bow_tag_to_follow : String = "bow1"

func _ready() -> void:
	BowGlobal.arrow_fired.connect(arrow_fired)
	BowGlobal.arrow_hit_something.connect(arrow_hit)
	BowGlobal.target_hit.connect(target_hit)
	BowGlobal.bow_charge_started.connect(bow_charge_started)

func arrow_fired(arrow : ArrowBody3D,cam_guide : CamGuide):
	cam.cur_cam_guide = cam_guide
	

func arrow_hit(arrow : ArrowBody3D, thing : Node3D):
	if thing is Target:
		return
	for c in arrow.get_children():
		if c is CamGuide:
			if c == cam.cur_cam_guide:
				cam.cur_cam_guide = get_bow_cam_guide()
	

func target_hit(target : Target,hit_by : ArrowBody3D,points : float):
	var cam_g : CamGuide = get_bow_cam_guide()
	for c in target.get_children():
		if c is CamGuide and c.tags.has("target_scored"):
			cam_g = c
			break
	cam.cur_cam_guide = cam_g

func bow_charge_started(bow_tags : Array[String]):
	if bow_tags.has(bow_tag_to_follow):
		cam.cur_cam_guide = get_bow_cam_guide()


func get_bow_cam_guide():
	for c :CamGuide in get_tree().get_nodes_in_group("cam_guide"):
		if c.tags.has("bow"):
			return c
