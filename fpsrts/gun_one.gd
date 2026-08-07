extends Node3D
var ammoTotal = 300
var ammmoRemaining = 60
var cooldown = false
var bullet = preload("uid://dqugpu8psytd5")
func triggerPull():
	if ammmoRemaining > 0 && !cooldown:
		shoot();
		ammmoRemaining -=1
		cooldown = true
		$Timer.start()
		test()
func shoot():
	$MeshInstance3D/gunflare.show()
	$MeshInstance3D/gunflare.flare()
	#$MeshInstance3D/gunflare.hide()

func test():
	var localBullet = bullet.instantiate()
	$projectilehold.add_child(localBullet)
	#$projectilehold.global_position += Vector3(0,0.1,0)
	var gunLocation = $".".global_position
	bullet.global_position 
	
func moveBulletAwayFromGun(gunX,gunZ,gunY, localBullet):
	if gunX > 0:
		localBullet.global_position += Vector3(0.1,0,0)
	
func _on_timer_timeout() -> void:
	cooldown = false
