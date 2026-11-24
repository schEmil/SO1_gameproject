extends Node

@export var charge_input_action : String = "charge1"

@export var charge_speed_a_sec : float = 10.0
@export var charge_max : float = 20.0
@export var charge_min : float = 0.0

var cur_charge : float = 0.0 :
	set(val):
		cur_charge = clamp(val,charge_min,charge_max)
	


var charging : bool = false :
	get():
		return not Input.is_action_pressed(charge_input_action)

signal started_charging(charge_am : float)
signal stopped_charging(charge_am : float)



func _process(delta: float) -> void:
	if charging:
		cur_charge += charge_speed_a_sec*delta
	

func _input(event: InputEvent) -> void:
	if event.is_action_released(charge_input_action):
		start_charge()
	elif event.is_action_pressed(charge_input_action):
		stop_charge()

func start_charge():
	cur_charge = charge_min
	started_charging.emit(cur_charge)
	print("charge_start: "+str(cur_charge))
	pass

func stop_charge():
	stopped_charging.emit(cur_charge)
	print("charge_stop: "+str(cur_charge))
	cur_charge = charge_min
	
	pass
