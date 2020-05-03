extends Node2D
export(String, "green", "red") var column_color

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if column_color == "green":
		$"kolumna".texture = load("res://images/kolumna_green.png")
		$"kolumna2".texture = load("res://images/kolumna_green.png")
	if column_color == "red":
		$"kolumna".texture = load("res://images/kolumna_red.png")
		$"kolumna2".texture = load("res://images/kolumna_red.png")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
