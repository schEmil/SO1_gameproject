extends Node3D
class_name Target

signal target_hit(arrow : ArrowBody3D,points : float)
signal ring_hit(arrow : ArrowBody3D,ring_num : int)

## ordered by ring distance and then points awardedS
@export var point_rings : Array[Vector2] = []
@export var default_points : float = 10.0
##y basis should point away in goal direction. and the node should be placed at in the middle the face where the arrow bursts through.
@export var target_surface_and_dir: Node3D
@export var debug_hit_show : Node3D = null

func hit_target(arrow : ArrowBody3D = null,hit_point : Vector3 = target_surface_and_dir.global_position):
	var r_d : float = calc_pierce_distance_to_center(hit_point)
	var points : float = default_points
	var ring : int = calc_ring_hit(r_d)
	if arrow:
		points = calc_point_from_hit(r_d)
	
	target_hit.emit(arrow,points)
	ring_hit.emit(arrow,ring)
	BowGlobal.target_hit.emit(self,arrow,points)
	print("TARGET_HIT with points: "+str(points))
	
	

func calc_point_from_hit(ring_dist : float = 0.0) -> float:
	var ring : int = calc_ring_hit(ring_dist)
	return point_rings[ring].y

func calc_ring_hit(ring_dist : float = 0.0) -> int:
	var closest_ring : int = 0
	var closest_dist : float = 9999999.9
	var cur_ring : int = 0
	
	for ring : Vector2 in point_rings:
		var dist : float = abs(ring.x-ring_dist)
		if dist < closest_dist:
			closest_ring = cur_ring
			closest_dist = dist
		
		cur_ring += 1
	return closest_ring

func calc_pierce_distance_to_center(point : Vector3) -> float:
	var global_arrow_pos : Vector3 = point
	
	
	
	var aligned_pos : Vector3 = flatten_vec3(target_surface_and_dir.to_local(global_arrow_pos),Vector3.UP)
	var dist : float = target_surface_and_dir.global_position.distance_to(point)
	if debug_hit_show:
		debug_hit_show.global_position = global_arrow_pos
	print("dist: "+str(dist))
	#print("dot: " +str(aligned_pos.dot(target_surface_and_dir.basis.y)))
	return dist

func flatten_vec3(vec3 : Vector3,flattener_vec3 : Vector3):
	var dot : float = vec3.dot(flattener_vec3)
	return vec3 -flattener_vec3*dot

func point_on_line(line_start : Vector3, line_end : Vector3, point_position : Vector3) -> Vector3:
	var line_direction := (line_start - line_end).normalized()
	var vector_to_object := point_position - line_start
	var distance := line_direction.dot(vector_to_object)
	var closest_position := line_start + distance * line_direction
	return closest_position

func get_instant_ray_col(from: Vector3, to : Vector3, col_mask : int):
	
	var space = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(from,to,col_mask)
	
	var collision : Dictionary = space.intersect_ray(query)
	return collision
