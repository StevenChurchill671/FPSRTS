extends CharacterBody3D
var followingPlayer = false
var health = 10
var alert = 5
var isAlert = false
var currentTarget 
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
	set_target(self)
func set_target(target):
	await get_tree().physics_frame
	agent.set_target_position(target.global_position)
#func _physics_process(delta):
	#set_target()
	#velocity = global_position.direction_to(agent.target_position) * speed
	#move_and_slide()
func _process(delta: float) -> void:
	var sightObject = $sightRange.get_collider()
	var object = $shootRange.get_collider()
	if object != null:
		if object.has_meta("enemy"):
			$gunOne.triggerPull()
	if sightObject != null:
		if sightObject.has_meta("enemy") :
			#rotate(Vector3.RIGHT, deg_to_rad(90))
			$".".look_at(sightObject.global_position, Vector3.UP)
			set_target(sightObject)
			velocity = global_position.direction_to(agent.target_position) * speed
			move_and_slide()
			alert = 10
	if isAlert && currentTarget != null:
		$".".look_at(currentTarget.global_position, Vector3.UP)
		set_target(currentTarget)
		velocity = global_position.direction_to(agent.target_position) * speed
		move_and_slide()
	if !isAlert && currentTarget !=null:
		$".".look_at(currentTarget.global_position, Vector3.UP)
		set_target(currentTarget)
		velocity = global_position.direction_to(agent.target_position) * speed
		move_and_slide()
	else:
		velocity = global_position.direction_to(agent.target_position) * speed
		move_and_slide()


func _on_alert_timer_timeout() -> void:
	if alert>0:
		alert -= 1
		$AlertTimer.start()
	if alert ==0:
		isAlert=false


func _on_alert_area_body_entered(body: Node3D) -> void:
	if alert > 0 && body.has_meta("enemy"):
		$".".look_at(body.global_position, Vector3.UP)
		set_target(body)
		velocity = global_position.direction_to(agent.target_position) * speed
		move_and_slide()
		isAlert = true
		alert = 5
		currentTarget = body
		$AlertTimer.start()


func _on_alert_area_body_exited(body: Node3D) -> void:
	currentTarget = null


 


func _on_follow_player_body_entered(body: Node3D) -> void:
	if body.has_meta("player") && !followingPlayer:
		if body.allyOne != null:
			set_target(body.addAllyToFollowPosition(self, 0))
			followingPlayer = true
		if body.allyTwo != null:
			set_target(body.addAllyToFollowPosition(self, 2))
			followingPlayer = true
		if body.allyThree != null:
			set_target(body.addAllyToFollowPosition(self, 4))
			followingPlayer = true
