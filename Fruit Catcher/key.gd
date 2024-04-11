extends StaticBody2D

signal door_opened

var keytaken = false
var in_door_zone = false


func _on_area_2d_body_entered(body: PhysicsBody2D):
	if not keytaken:
		keytaken = true
		$Sprite2D.queue_free()
		print("Key taken:", keytaken)

func _process(delta):
	if keytaken:
		if in_door_zone:
			if Input.is_action_just_pressed("ui_open"):
				print("door_opened")
				emit_signal("door_opened")
				get_tree().change_scene_to_file("res://Levels/level_2.tscn")

func _on_door_zone_body_entered(body: PhysicsBody2D):
	in_door_zone = true
	print("In door zone:", in_door_zone)
	if Input.is_action_just_pressed("ui_open"):
		get_tree().change_scene_to_file("res://Levels/level_2.tscn")

func _on_door_zone_body_exited(body: PhysicsBody2D):
	in_door_zone = false
	print("In door zone:", in_door_zone)

