extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var color = "Red"
var vial
var space
# Called when the node enters the scene tree for the first time.
func _ready():
	if(color == "Red"):
		$Sprite.texture = load("res://ball_red.png")
	elif(color == "Blue"):
		$Sprite.texture = load("res://ball_blue.png")
	elif(color == "Yellow"):
		$Sprite.texture = load("res://ball_yellow.png")
	elif(color == "Green"):
		$Sprite.texture = load("res://ball_green.png")

func _on_TextureButton_pressed():
	print("Vial: " + str(vial) + ", space: " + str(space) + ", color: " + color)

func _to_string():
	return(color + ";" + str(vial) + ":" + str(space))
