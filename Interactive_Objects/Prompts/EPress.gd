extends Node


func _on_Node2D_area_entered(area):
	EventsSingleton.emit_signal("button_prompt", "Press E...")


func _on_Node2D_area_exited(area):
	EventsSingleton.emit_signal("button_prompt_over")
