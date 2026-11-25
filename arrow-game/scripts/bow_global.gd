extends Node

signal arrow_fired(arrow : ArrowBody3D,cam_guide : CamGuide)

signal arrow_hit_something(arrow : ArrowBody3D,hit_thing : Node3D)

signal target_hit(target : Target,hit_by : ArrowBody3D,points : float)

signal bow_charge_started(bow_tags : Array[String])
