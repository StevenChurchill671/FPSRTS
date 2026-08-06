extends Node3D
var ammoTotal = 300
var ammmoRemaining = 60

func triggerPull():
	if ammmoRemaining > 0:
		shoot();
		ammmoRemaining -=1
func shoot():
	$MeshInstance3D/gunflare.show()
	$MeshInstance3D/gunflare.flare()
	#$MeshInstance3D/gunflare.hide()
