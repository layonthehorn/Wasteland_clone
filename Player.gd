extends KinematicBody2D

# Vector of two objects
var velocity = Vector2.ZERO
enum {
	MOVE,
	
}
var state = MOVE
const MAX_SPEED = 40
const ACCELERATION = 500
const FRICTION = 500

# tracking player movement
# main loop
func _physics_process(delta):
	
	# light state machine to switch states
	match state:
		MOVE:
			move_state(delta)


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