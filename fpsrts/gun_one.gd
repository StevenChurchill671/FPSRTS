extends Node3D
var ammoTotal = 300
var ammmoRemaining = 60
var cooldown = false
var waiting = false
var bullet = preload("uid://dqugpu8psytd5")
func triggerPull():
	if ammmoRemaining > 0 && !cooldown:
		shoot();
		ammmoRemaining -=1
		cooldown = true
		$fireRate.start()
		test()
func shoot():
	$MeshInstance3D/gunflare.show()
	$MeshInstance3D/gunflare.flare()
	#$MeshInstance3D/gunflare.hide()

func test():
	var localBullet = bullet.instantiate()
	$projectilehold.add_child(localBullet)
	localBullet.rotate(Vector3.UP, deg_to_rad(90))
	#$projectilehold.global_position += Vector3(0,0.1,0)
	#var gunLocation = $".".global_position
	#localBullet.position += Vector3(0,0.1,0)
	bulletDistancer(localBullet)
func bulletDistancer(localBullet):
	var localBulletDistance = 10
	while localBulletDistance > 0:
		waiting = true
		$bulletdelayer.start()
		await _on_bulletdelayer_timeout()
		localBullet.position += Vector3(0,0.1,0)
		localBulletDistance -=1
	#localBullet.queue_free()
	
func _on_timer_timeout() -> void:
	cooldown = false


func _on_bulletdelayer_timeout() -> void:
	waiting= false
