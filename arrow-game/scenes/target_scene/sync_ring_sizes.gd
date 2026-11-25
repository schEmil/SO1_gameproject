extends Node

@export var target : Target
@export var rings : RingSizer

func _ready() -> void:
	var r_arr : PackedFloat32Array = []
	for r : Vector2 in target.point_rings:
		r_arr.append(r.x)
	rings.ring_sizes = r_arr
	rings.update_ring_sizes()
	print("rings_updated")
