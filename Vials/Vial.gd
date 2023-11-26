extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text
var balls = []
var active = false
# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.vials.append(self)

var BallClass = preload("res://Ball.tscn")
const ERROR = preload("res://Error.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	

func _on_TextureButton_pressed():
	if(Globals.lastVial):
		if(Globals.lastVial!=self):
			changeBall(Globals.lastVial, self)
		Globals.lastVial.find_node("ActiveMarker").visible = false
		Globals.lastVial.find_node("Walls").color = "ffffff"
		Globals.lastVial.active = false
		Globals.lastVial = null
	else:
		Globals.lastVial = self
		active = true
		#$ActiveMarker.visible = true
		$Walls.color = "8d8d8d"

func changeBall(source: Node2D , target: Node2D):
	print("Source: " + str(source.balls))
	print("Target: " + str(target.balls))
	if(source.balls.back()):
		var lastball = BallClass.instance()
		lastball.color = source.balls.back().color
		lastball.vial = source.balls.back().vial
		lastball.space = source.balls.back().space
		if(target.balls.size()<4):
			if(!target.balls.empty()):
				if(target.balls.back().color==lastball.color):
					var prevSpace = lastball.space
					lastball.space = target.balls.back().space +1
					target.balls.append(lastball)
					target.get_node("Space"+str(lastball.space)).add_child(lastball)
					source.get_node("Space"+str(prevSpace)).get_node("Ball").queue_free()
					source.balls.erase(source.balls.back())
				else:
					print("Error: different color in vial")
					#get_tree().current_scene.add_child(ERROR.instance())
			else:
				var prevSpace = lastball.space
				lastball.space = 0
				target.balls.append(lastball)
				target.get_node("Space0").add_child(lastball)
				source.get_node("Space"+str(prevSpace)).get_node("Ball").queue_free()
				source.balls.erase(source.balls.back())
		else:
			print("Error: full vial")
	else:
		print("Error: empty vial")

func changeAdminBall(source: Node2D, target: Node2D):
	if(!source.balls.empty()):
		var lastball = BallClass.instance()
		lastball.color = source.balls.back().color
		lastball.vial = source.balls.back().vial
		lastball.space = source.balls.back().space
		if(target.balls.size()<4):
			if(!target.balls.empty()):
				var prevSpace = lastball.space
				lastball.space = target.balls.back().space +1
				target.balls.append(lastball)
				target.get_node("Space"+str(lastball.space)).add_child(lastball)
				source.get_node("Space"+str(prevSpace)).get_node("Ball").queue_free()
				source.balls.erase(source.balls.back())
			else:
				var prevSpace = lastball.space
				lastball.space = 0
				target.balls.append(lastball)
				target.get_node("Space0").add_child(lastball)
				source.get_node("Space"+str(prevSpace)).get_node("Ball").queue_free()
				source.balls.erase(source.balls.back())
