extends Area3D
class_name ArrowBody3D

@export var velocity : Vector3 = Vector3(0.0,1.0,-1.0)
@export var arrow_gravity : Vector3 = Vector3.DOWN*4.0

@export var rotation_lerp_speed : float = 60.0

@export var gravity_affect : float = 0.0

@export var active_flying : bool = true

signal hit_something(hit_thing : Node3D)

func _ready() -> void:
	body_entered.connect(on_body_entered)
	

func on_body_entered(body : Node3D):
	active_flying = false
	reparent.call_deferred(body)
	global_position -= velocity.normalized()*0.005
	#set_deferred("process_mode",ProcessMode.PROCESS_MODE_DISABLED)
	hit_something.emit(body)
	BowGlobal.arrow_hit_something.emit(self,body)

func _physics_process(delta: float) -> void:
	if not active_flying:
		return
	
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
