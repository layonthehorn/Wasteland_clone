extends CanvasLayer

var number_points = 10
var points_used = 0

# opens the inventory
func _on_Inventory_pressed():
	print("Inventory")

# opens the squad management window
func _on_Squad_pressed():
	print("Squad")

# saves the game
func _on_Save_pressed():
	print("Save")

# quits the game
func _on_Quit_pressed():
	 get_tree().quit()
