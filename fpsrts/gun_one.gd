extends Node3D
var ammoTotal = 300
var ammmoRemaining = 60
var cooldown = false

func triggerPull():
	if ammmoRemaining > 0 && !cooldown:
		shoot();
		ammmoRemaining -=1
		cooldown = true
		$Timer.start()
func shoot():
	$MeshInstance3D/gunflare.show()
	$MeshInstance3D/gunflare.flare()
	#$MeshInstance3D/gunflare.hide()

func test():
	var bullet = MeshInstance3D.new()
	$projectile.add_child(bullet)
	
func _on_timer_timeout() -> void:
	cooldown = false
