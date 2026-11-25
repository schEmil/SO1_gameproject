extends Node

@export var bow_tags : Array[String]

func emit_bow_charge_start():
	BowGlobal.bow_charge_started.emit(bow_tags)
