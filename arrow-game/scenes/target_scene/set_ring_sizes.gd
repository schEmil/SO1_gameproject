extends Node3D
class_name RingSizer

@export var ring_sizes : PackedFloat32Array = []
@export var update_on_ready : bool = true

func _ready() -> void:
	if update_on_ready:
		update_ring_sizes()

func update_ring_sizes():
	var ring_num : int = 0
	for r : Node in get_children():
		if r is Node3D:
			if ring_num >= ring_sizes.size():
				break
			r.basis = r.basis.orthonormalized()*ring_sizes[ring_num]
			r.basis.y = r.basis.y.normalized()
			ring_num += 1
			print("a")
			
