extends RayCast3D
class_name ArrowBody3D

@export var velocity : Vector3 = Vector3(0.0,1.0,-1.0)
@export var arrow_gravity : Vector3 = Vector3.DOWN*4.0

@export var rotation_lerp_speed : float = 60.0

@export var gravity_affect : float = 0.0

@export var active_flying : bool = true
@export var arrow_length : float = 2.0

var prev_global_trans : Transform3D = Transform3D.IDENTITY

signal hit_something(hit_thing : Node3D,point : Vector3, normal : Vector3)


func on_ray_hit_something(body : Node3D,hit_point : Vector3, normal : Vector3):
	active_flying = false
	enabled = false
	#test_to place arrow more precisely by proxy
	#global_transform = global_transform.interpolate_with(prev_global_trans,0.5)
	
	
	
	set_deferred("process_mode",ProcessMode.PROCESS_MODE_DISABLED)
	
	reparent.call_deferred(body)
	#global_position -= velocity.normalized()*0.005
	
	hit_something.emit(body,hit_point,normal)
	if body is Target:
		body.hit_target(self,hit_point)
	BowGlobal.arrow_hit_something.emit(self,body,hit_point,normal)
	print("arrow_enter")

func _physics_process(delta: float) -> void:
	if not active_flying:
		return
	if is_colliding():
		on_ray_hit_something(get_collider(),get_collision_point(),get_collision_normal())
		return
	prev_global_trans = global_transform
	global_position += velocity*delta
	velocity += arrow_gravity*delta
	
	var target_dir : Vector3 = velocity.normalized()
	var target_basis : Basis = align_with_y(global_basis,target_dir.normalized())
	global_basis = global_basis.slerp(target_basis,clamp(delta*rotation_lerp_speed,0.0,1.0)).orthonormalized()
	
	pass

func align_with_y(xform : Basis, new_y : Vector3):
	xform.y = new_y
	xform.x = -xform.z.cross(new_y)
	xform = xform.orthonormalized()
	return xform
