extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var points = 0 #liczba kolumn 
var columns = 0
export var speed = 1
export var score = 0 
var stop_movemet = false # bool true = died and background need to stop moving
var f_hiscore = File.new() # File with save of a hiscore
var hiscore = -1
var rng = RandomNumberGenerator.new()
var luka_scene = load("res://scenes/luka.tscn")
var settings = {"BirdColor"   : "blue",
				"ColumnColor" : "green"}


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	# Settings restore at the begining of every game
	var f_settings = File.new()
	if not f_settings.file_exists("user://settings.dat"):
		print_debug("Settings file does not exist. Creating new...")
		f_settings.open("user://settings.dat", File.WRITE)
		f_settings.store_var(settings)
		f_settings.close()
	f_settings.open("user://settings.dat", File.READ)	
	settings = f_settings.get_var()
	print_debug("Saved settings :  ", settings)
	f_settings.close()
	$"../bird".animation_type = settings["BirdColor"]
	#$"../bird".animation_type = settings["ColumnColor"]
	
	
	
	f_hiscore.open("user://hiscore.save", File.READ)
	hiscore = f_hiscore.get_var()
	f_hiscore.close()
	pass # Replace with function body.
# Function called when tou die
func die():
	print("dead")
	stop_movemet = true
	$"../Panel".visible = true
	$"../Panel/Label2".text = "Score: " + String(score) 
	if(score > hiscore):
		hiscore = score
		f_hiscore.open("user://hiscore.save", File.WRITE_READ)
		f_hiscore.store_var(hiscore)
		print(f_hiscore.get_var())
		f_hiscore.close()
	$"../Panel/Label3".text = "Hicore: " + String(hiscore) 
	
	pass
# CHEAT CODES
func _input(event):
	if(event.is_action("key_q")):
		speed *= 2
	if(event.is_action("key_m")):
		score *= 2
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(!stop_movemet):
		self.position.x += -speed
	if $"../bird".global_position.y > 950 or $"../bird".global_position.y < -50:
		die()
	pass

func _on_bird_area2D_entered(area):
	if(area.type == 0):
		score += 1
		var luka_scene_object = luka_scene.instance()
		luka_scene_object.position.x = -self.position.x + columns * 400
		luka_scene_object.position.y = self.position.y + rng.randf_range(-300,300)
		luka_scene_object.scale = Vector2(15,20) 
		columns += 1
		luka_scene_object.column_color = settings["ColumnColor"]
		self.add_child(luka_scene_object)
		$"../Panel2/Label".text = String(score)
		speed *= 1.1
	if(area.type == 1):
		die()
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
	luka_scene_object.column_color = settings["ColumnColor"]
	self.add_child(luka_scene_object)
	if(columns > 4):
		$"../Timer".stop()
	pass # Replace with function body.
