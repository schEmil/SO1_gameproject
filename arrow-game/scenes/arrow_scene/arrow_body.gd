extends RigidBody3D
class_name ArrowBody3D

@export var rotation_lerp_speed : float = 60.0
@export var rotation_speed_scaling : float = 1.0

@export var gravity_affect : float = 0.0

func _physics_process(delta: float) -> void:
	var target_dir : Vector3 = linear_velocity.normalized()
	target_dir += get_gravity().normalized() * gravity_affect
	var target_basis : Basis = align_with_y(global_basis,target_dir.normalized())
	if linear_velocity.length() > 0.0:
		angular_velocity = lerp(angular_velocity,(target_basis.get_euler() - global_basis.get_euler())*rotation_speed_scaling,clamp(delta*linear_velocity.length()*rotation_lerp_speed,0.0,1.0))
	pass

func align_with_y(xform : Basis, new_y : Vector3):
	xform.y = new_y
	xform.x = -xform.z.cross(new_y)
	xform = xform.orthonormalized()
	return xform
