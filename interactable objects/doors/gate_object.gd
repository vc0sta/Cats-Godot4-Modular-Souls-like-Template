extends StaticBody3D

@onready var opened = false
@onready var gate_anim_player :AnimationPlayer = $GateAnimPlayer

@export var locked : bool = false
var anim

func activate(_requestor,_sensor_loc):
	if locked:
		shake_gate()
		
	else:
		var dist_to_front = to_global(Vector3.FORWARD).distance_to(_requestor.global_position)
		var dist_to_back = to_global(Vector3.BACK).distance_to(_requestor.global_position)
		
		var new_translation = global_transform
		if dist_to_front > dist_to_back:
			new_translation = global_transform.rotated_local(Vector3.UP,PI)
		new_translation = new_translation.translated_local(Vector3(0,_requestor.global_position.y,-1))
		var move_time = .3
		
		if opened == false:
			_requestor.start_gate(new_translation, move_time)
			await get_tree().create_timer(move_time + 1).timeout
			open_gate()

func shake_gate():
	gate_anim_player.play("Locked")
	
func open_gate():
	anim = "Open"
	gate_anim_player.play(anim)
	opened = true

