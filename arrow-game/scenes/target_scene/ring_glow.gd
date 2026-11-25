extends Node

@export var ring_holder : RingSizer
@export var glow_mat : Material 
@export var glow_time : float = 1.0


func glow_a_ring_from_arrow_hit(arrow : ArrowBody3D,ring_num : int = 0):
	glow_a_ring(ring_num)

func glow_a_ring(ring_num : int = 0):
	var ring : Node = ring_holder.get_child(ring_num)
	var num : int = 0
	
	if ring is MeshInstance3D:
		var mat_bef : Material = ring.material_overlay
		ring.material_overlay = glow_mat
		var g_timer : Timer = Timer.new()
		g_timer.wait_time = glow_time
		g_timer.one_shot = true
		g_timer.timeout.connect(ring.set.bindv(["material_overlay",null]))
		g_timer.timeout.connect(g_timer.queue_free)
		ring.add_child(g_timer)
		g_timer.start()
		print(ring_num)
	
	pass
