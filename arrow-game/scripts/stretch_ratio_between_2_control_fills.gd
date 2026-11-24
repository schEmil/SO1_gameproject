@tool
extends Node

@export var filler : Control 
@export var defiller : Control

@export var ratio : float = 0.0 : set=set_stretch_ratio
signal ratio_just_set(_ratio : float)

var past_ready : bool = false

func _ready() -> void:
	past_ready = true

func set_stretch_ratio(val : float):
	if not ratio == val:
		ratio = val
		if not past_ready:
			await ready
		filler.size_flags_stretch_ratio = ratio
		defiller.size_flags_stretch_ratio = 1.0-ratio
		ratio_just_set.emit(ratio)


func _on_updator_constant_bc_ratio(ratio: float) -> void:
	pass # Replace with function body.
