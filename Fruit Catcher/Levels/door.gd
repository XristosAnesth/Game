extends StaticBody2D

var entered = false
var keytaken = false

func _on_key_door_opened(body: PhysicsBody2D):
	keytaken = true
	print("Key taken:", keytaken)

func _on_door_zone_body_entered(body: PhysicsBody2D):
	entered = true
	print("Entered door zone:", entered)

func _process(delta):
	if entered and keytaken:  # Check if the player is in the door zone and has the key
		if Input.is_action_just_pressed("ui_open"):
			print("Scene changing...")
			get_tree().change_scene_to_file("res://Levels/level_2.tscn")
