extends CharacterBody3D

var health = 10
var enemy = true
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
func set_target(target):
	await get_tree().physics_frame
	agent.set_target_position(target)
#func _physics_process(delta):
	#set_target()
	#velocity = global_position.direction_to(agent.target_position) * speed
	#move_and_slide()
func _process(delta: float) -> void:
	var sightObject = $sightRange.get_collider()
	var object = $shootRange.get_collider()
	if object.has_meta("enemy"):
		$gunOne.shoot()
		
	if sightObject.has_meta("enemy") :
		#rotate(Vector3.RIGHT, deg_to_rad(90))
		$".".look_at(sightObject.global_position, Vector3.UP)
		set_target(sightObject)
		velocity = global_position.direction_to(agent.target_position) * speed
		move_and_slide()
