extends Node

@export var b_c_input : BowChargeInput
signal constant_bc_ratio(ratio : float)
var last_bc_ratio : float = 0.0
func _process(delta: float) -> void:
	if not b_c_input:
		return
	last_bc_ratio = (b_c_input.cur_charge - b_c_input.charge_min)/b_c_input.charge_max
	constant_bc_ratio.emit(last_bc_ratio) 
