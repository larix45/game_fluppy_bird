extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal area2D_entered(area)

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	self.global_position.y += 3
	if(Input.is_action_pressed("ui_accept")):
		self.global_position.y -= 30
		self.global_rotation_degrees = -7
	else:
		self.global_rotation_degrees = 7
	pass


func _on_Area2D_area_entered(area):
	emit_signal("area2D_entered", area)
	pass # Replace with function body.
