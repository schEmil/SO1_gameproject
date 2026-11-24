extends Node3D

@export var arrow_scene : PackedScene = preload("res://scenes/arrow_scene/arrow.tscn")
@export var speed : float = 10.0

func spawn_arrow(arrow_speed : float = speed):
	var arrow_inst : RigidBody3D = arrow_scene.instantiate()
	add_child(arrow_inst)
	arrow_inst.linear_velocity = global_basis.y.normalized()*arrow_speed
