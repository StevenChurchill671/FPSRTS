extends Node3D
var ammoTotal = 300
var ammmoRemaining = 60
var cooldown = false
var waiting = false
var bullet = preload("uid://dqugpu8psytd5")

func _ready() -> void:
	$gunAmmoCount.mesh = $gunAmmoCount.mesh.duplicate()
	
func triggerPull():
	if ammmoRemaining > 0 && !cooldown:
		shoot();
		ammmoRemaining -=1
		$gunAmmoCount.mesh.text = "" + str(ammmoRemaining) 
		cooldown = true
		$fireRate.start()
		test()
func shoot():
	$MeshInstance3D/gunflare.show()
	$MeshInstance3D/gunflare.flare()
	#$MeshInstance3D/gunflare.hide()

func test():
	var localBullet = bullet.instantiate()
	$".".add_child(localBullet)
	#get_parent().get_parent().add_child(localBullet)
	#localBullet.global_position = $".".global_position
	#localBullet.global_rotation = $".".global_rotation
	localBullet.rotate(Vector3.FORWARD, deg_to_rad(90))
	#$projectilehold.global_position += Vector3(0,0.1,0)
	#var gunLocation = $".".global_position
	#localBullet.position += Vector3(0,0.1,0)
	bulletDistancer(localBullet)
func bulletDistancer(localBullet):
	var localBulletDistance = 60
	while localBulletDistance > 0:
		waiting = true
		$bulletdelayer.start()
		await $bulletdelayer.timeout
		localBullet.position += Vector3(0.2,0,0)
		localBulletDistance -=1
	localBullet.queue_free()
	
	
func reloadWeapon():
	var ammoNeeded = ammmoRemaining -60
	var tempTotal = ammoTotal 
	ammoTotal += ammoNeeded
	ammmoRemaining += (tempTotal - ammoTotal)
	$gunAmmoCount.mesh.text = "" + str(ammmoRemaining) 
	 
	 
func _on_timer_timeout() -> void:
	cooldown = false


func _on_bulletdelayer_timeout() -> void:
	waiting= false
