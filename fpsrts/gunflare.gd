extends Node3D


func _ready() -> void:
	$AnimationPlayer.speed_scale = 50
func flare():
	$AnimationPlayer.play("Cylinder_001Action")
	


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	$".".hide()
