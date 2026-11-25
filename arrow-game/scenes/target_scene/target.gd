extends Node3D
class_name Target

signal target_hit(arrow : ArrowBody3D,points : float)
signal ring_hit(arrow : ArrowBody3D,ring_num : int)

## ordered by ring distance and then points awardedS
@export var point_rings : Array[Vector2] = []
@export var default_points : float = 10.0
@export var target_direction_holder : Node3D

func hit_target(arrow : ArrowBody3D = null):
	var points : float = default_points
	var ring : int = calc_ring_hit(arrow)
	if arrow:
		points = calc_point_from_hit(arrow)
	
	target_hit.emit(arrow,points)
	ring_hit.emit(arrow,ring)
	BowGlobal.target_hit.emit(self,arrow,points)
	print("TARGET_HIT with points: "+str(points))
	
	

func calc_point_from_hit(arrow : Node3D) -> float:
	var ring : int = calc_ring_hit(arrow)
	return point_rings[ring].y

func calc_ring_hit(arrow : Node3D) -> int:
	var ring_dist : float = calc_pierce_distance_to_center(arrow)
	var closest_ring : int = 0
	var closest_dist : float = 9999999.9
	var cur_ring : int = 0
	for ring : Vector2 in point_rings:
		var dist : float = abs(ring.x-ring_dist)
		if dist <= closest_dist:
			closest_ring = cur_ring
			closest_dist = dist
		
		cur_ring += 1
	return closest_ring

func calc_pierce_distance_to_center(arrow : Node3D) -> float:
	var global_arrow_pos : Vector3 = arrow.global_position
	if arrow is ArrowBody3D:
		global_arrow_pos += arrow.global_basis.y*arrow.arrow_length*0.5
	var aligned_pos : Vector3 = flatten_vec3(target_direction_holder.to_local(global_arrow_pos),Vector3.UP)
	var dist : float = aligned_pos.length()
	#$target_col/CSGSphere3D.position = flatten_vec3(target_direction_holder.to_local(global_arrow_pos),Vector3.UP)
	print("dist: "+str(dist))
	print("dot: " +str(aligned_pos.dot(target_direction_holder.basis.y)))
	return dist

func flatten_vec3(vec3 : Vector3,flattener_vec3 : Vector3):
	var dot : float = vec3.dot(flattener_vec3)
	return vec3 -flattener_vec3*dot
