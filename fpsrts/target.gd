extends CharacterBody3D

var health = 10

func damaged():
	health -= 1
	if health < 1:
		queue_free()
		


func _on_target_area_3d_area_entered(area: Area3D) -> void:
	if area.has_meta("bulletArea"):
		damaged()

var speed := 2.0
@onready var agent: NavigationAgent3D = $NavigationAgent3D
func _ready():
	agent.path_desired_distance = 0.5
	agent.target_desired_distance = 0.5
func set_target():
	await get_tree().physics_frame
	agent.set_target_position(get_parent().get_parent().get_child(0).global_position)
func _physics_process(delta):
	set_target()
	velocity = global_position.direction_to(agent.target_position) * speed
	move_and_slide()
func _process(delta: float) -> void:
	var sightObject = $sightRange.get_collider()
	var object = $shootRange.get_collider()
	if object == get_parent().get_parent().get_child(0):
		$gunOne.shoot()
	if sightObject == get_parent().get_parent().get_child(0):
		rotate(Vector3.RIGHT, deg_to_rad(90))
