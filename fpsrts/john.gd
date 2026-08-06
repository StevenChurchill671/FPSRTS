extends CharacterBody3D


@export var speed = 5.0
#@export var target_path = NodePath()   # The target (usually the player) node path
 
@onready
var target =  GlobalStore.player
var agent : NavigationAgent3D

func _ready():
	# Get the NavigationAgent3D node
	agent = $NavigationAgent3D
	# Get the target node from exported NodePath
	#target = get_node(target_path) if target_path != null else null

func _physics_process(delta):
	if target == null:
		return

	# Set the target position for navigation
	agent.set_target_position(target.global_transform.origin)

	# Get next position on the path
	var next_position = agent.get_next_path_position()

	# Calculate direction towards the next path point
	var direction = (next_position - global_transform.origin).normalized()

	# Move the enemy using the built-in movement function (Godot 4.x)
	self.velocity = direction * speed
	move_and_slide()

	# Optional: Rotate enemy to face the direction of movement
	if direction.length() > 0.1:
		look_at(global_transform.origin + direction, Vector3.UP)
