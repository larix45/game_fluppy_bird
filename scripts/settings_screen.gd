extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var settings = {"BirdColor"   : "blue",
				"ColumnColor" : "green"}
				
var translation_bird_color = {"blue" : 0,
							  "white": 1,
							  "green": 2}
							
var translation_bird_color_reverse = {0 : "blue",
									  1 : "white",
									  2 : "green"}
							
var translation_column_color = {"green" : 0,
								"red": 1}
var translation_column_color_reverse = {0 : "green",
										1 : "red"}
func save_settings():
	var f_settings = File.new()
	f_settings.open("user://settings.dat", File.WRITE)
	f_settings.store_var(settings)
	f_settings.close()
	pass
func load_settings():
	var f_settings = File.new()
	f_settings.open("user://settings.dat", File.READ)
	settings = f_settings.get_var()
	f_settings.close()
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	load_settings()
	$"ScrollContainer/VBoxContainer/HBoxContainer/OptionButton".selected = translation_bird_color[settings["BirdColor"]]
	$"ScrollContainer/VBoxContainer/HBoxContainer2/OptionButton2".selected = translation_column_color[settings["ColumnColor"]]
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Save settings
func _on_Button_pressed():
	settings["BirdColor"] = translation_bird_color_reverse[$"ScrollContainer/VBoxContainer/HBoxContainer/OptionButton".selected]
	settings["ColumnColor"] = translation_column_color_reverse[$"ScrollContainer/VBoxContainer/HBoxContainer2/OptionButton2".selected]
	save_settings()
	get_tree().change_scene("res://main.tscn")
	pass # Replace with function body.


func _on_Button2_pressed():
	load_settings()
	$"ScrollContainer/VBoxContainer/HBoxContainer/OptionButton".selected = translation_bird_color[settings["BirdColor"]]
	$"ScrollContainer/VBoxContainer/HBoxContainer2/OptionButton2".selected = translation_column_color[settings["ColumnColor"]]
	pass # Replace with function body.


func _on_Button_del_hiscore_pressed():
	$"PopupDialog".popup()
	pass # Replace with function body.

func _on_Button_yes_pressed():
	var f_hiscore = File.new()
	f_hiscore.open("user://hiscore.save", File.WRITE)
	f_hiscore.store_var(0)
	f_hiscore.close()
	$"PopupDialog".hide()
	pass # Replace with function body.


func _on_Button2_yes_pressed():
	$"PopupDialog".hide()
	pass # Replace with function body.
