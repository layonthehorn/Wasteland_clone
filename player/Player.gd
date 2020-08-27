extends KinematicBody2D

# Vector of two objects
var velocity = Vector2.ZERO
enum {
	MOVE,
	TEST,
	FIGHT
	
}
var state = MOVE
const MAX_SPEED = 40
const ACCELERATION = 500
const FRICTION = 500

# tracking player movement
# main loop
func _physics_process(delta):
	state_picker()
	
	# light state machine to switch states
	match state:
		MOVE:
			move_state(delta)
		TEST:
			var current_weapon = WeaponObject.new("M16")
			print(current_weapon.debug_stats())
		FIGHT:
			pass
			

func _ready():
	EventsSingleton.connect("button_prompt", self, "update_label")
	EventsSingleton.connect("button_prompt_over", self, "reset_label")
	

func state_picker():
	if Input.is_action_just_pressed("test_script"):
		state = TEST
	else:
		state = MOVE

# Functions below here.

func move_state(delta):
	var input_vector = get_input()
	
	if input_vector != Vector2.ZERO:
		# slowly increases our speed every frame input is pressed
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		# if not pressing buttons it slows you to a stop
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	# saving current velocity for later next physics check
	velocity = move_and_slide(velocity)


func get_input():
	var input_vector = Vector2.ZERO
	# getting right and left input
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	# getting up and down input
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	# normalizing them together to prevent faster diaganal moving
	input_vector = input_vector.normalized()
	return input_vector
	
func update_label(label_contents):
	var label = $Label
	label.visible = true
	label.set_text(label_contents)

func reset_label():
	var label = $Label
	label.visible = false
	label.set_text("")
