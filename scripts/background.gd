extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var points = 0 #liczba kolumn 
var columns = 0
export var speed = 1
export var score = 0 
var rng = RandomNumberGenerator.new()
var luka_scene = load("res://scenes/luka.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	pass # Replace with function body.

# CHEAT CODES
func _input(event):
	if(event.is_action("key_q")):
		speed *= 2
	if(event.is_action("key_m")):
		score *= 2
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.position.x > 100:
		self.position.x = 1
	self.position.x += -speed
	if $"../bird".global_position.y > 950 or $"../bird".global_position.y < -50:
		print("dead")
		$"../Panel".visible = true
		$"../Panel/Label2".text = "score: " + String(score) 
	pass

func _on_bird_area2D_entered(area):
	if(area.type == 0):
		score += 1
		var luka_scene_object = luka_scene.instance()
		luka_scene_object.position.x = -self.position.x + columns * 400
		luka_scene_object.position.y = self.position.y + rng.randf_range(-300,300)
		luka_scene_object.scale = Vector2(15,20) 
		columns += 1
		self.add_child(luka_scene_object)
		$"../Panel2/Label".text = String(score)
		speed *= 1.1
	if(area.type == 1):
		print("dead")
		$"../Panel".visible = true
		$"../Panel/Label2".text = "score: " + String(score) 
	pass # Replace with function body.


func _on_Button_pressed():
	get_tree().change_scene("res://scenes/game.tscn")
	pass # Replace with function body.


func _on_Button2_pressed():
	get_tree().change_scene("res://main.tscn")
	pass # Replace with function body.


func _on_Timer_timeout():
	var luka_scene_object = luka_scene.instance()
	luka_scene_object.position.x = -self.position.x + columns * 400
	luka_scene_object.position.y = self.position.y + rng.randf_range(-300,300)
	luka_scene_object.scale = Vector2(15,20) 
	columns += 1
	self.add_child(luka_scene_object)
	if(columns > 4):
		$"../Timer".stop()
	pass # Replace with function body.
