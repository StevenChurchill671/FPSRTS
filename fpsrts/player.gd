extends CharacterBody3D

var isMapOpen = false
var map
@onready
var camera = $Camera3D
@onready
var collisionShape = get_child(1)
var stamina =  0
var maxStamina =   100
@export var speed = 8.0 # Movement speed
var originalSpeed = speed
@export var gravity = 50.0 # Gravity
var jumpHeight = 20
# this is commented out var velocity = Vector3.ZERO
var crouched = false
var notCurrentlyCrouched = true
var crouchedTime = 7
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	self.name = "player"
	GlobalStore.assignPlayer(self)
func  _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion && not isMapOpen:
		rotate_y(-event.relative.x * .005)
		camera.rotate_x(-event.relative.y * .005)
		camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)
func _physics_process(delta):
	var inputDirection = Input.get_vector("left", "right", "down", "up")
	var forward = -camera.global_transform.basis.z
	var right = camera.global_transform.basis.x
	var direction = (right * inputDirection.x + forward * inputDirection.y).normalized()
	if Input.is_action_pressed("crouch"):
		self.scale =  Vector3(0.45, 0.45, 0.45)
		speed = 7
		crouched = true
		notCurrentlyCrouched = false
		crouchedTime = 4
	if Input.is_action_pressed("left_click"):
		$Camera3D/gunOne2.triggerPull()
	if Input.is_action_just_pressed("jump"): #&& stamina >= 20 :
		#stamina -= 20
		self.velocity.y = jumpHeight 
	
	# Normalize direction to prevent faster diagonal movement
	if direction != Vector3.ZERO && ! isMapOpen:
		self.velocity.x = direction.x * speed
		self.velocity.z = direction.z * speed
	else:
		self.velocity.x = move_toward(self.velocity.x, 0 , speed)
		self.velocity.z = move_toward(self.velocity.z, 0 , speed)
	# Apply horizontal velocity
	
	# Apply gravity when not on the floor
	if not is_on_floor():
		self.velocity.y -= gravity * delta
	
	
	# Move the character
	
	#print("Direction:", direction)
	#aprint("Velocity:", velocity)
	#print("Input Direction:", inputDirection)
	#print("World Direction:", direction)
	#print("Final Velocity:", self.velocity)
	move_and_slide()

func addToMaxStamina() -> void:
	maxStamina += 20
	$Camera3D/SubViewportContainer/SubViewport/StaminaProgressBar.max_value = maxStamina
func _on_timer_timeout() -> void:
	
	if stamina < maxStamina:
		stamina += 1
		if is_on_floor() &&stamina < maxStamina:
			stamina+=1
			#if stamina < maxStamina:
				#stamina += 2
	$Camera3D/SubViewportContainer/SubViewport/StaminaLabel.text = str(round(stamina/20))
	$Camera3D/SubViewportContainer/SubViewport/StaminaProgressBar.value = stamina
	if crouched && crouchedTime <0:
		self.scale =  Vector3(1, 1, 1)
		speed = originalSpeed
		crouched = false
		crouchedTime = 4
	if !notCurrentlyCrouched:
		crouchedTime -= 1

#func _on_stamina_token_tree_entered() -> void:
	#addToMaxStamina()
	#$"../StaminaToken".hide()


func _on_stamina_token_stamina_token_collected() -> void:
	addToMaxStamina()
