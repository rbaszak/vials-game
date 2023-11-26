extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rng = RandomNumberGenerator.new()
var VIAL = preload("res://Vial.gd")

var finish = false
# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	Globals.colors_dict["Red"]=4
	Globals.colors_dict["Blue"]=4
	Globals.colors_dict["Yellow"]=4
	Globals.colors_dict["Green"]=4
	Globals.lastVial = null
	Globals.vials.clear()
	Music.play(Globals.musicStop)
	var vial = load("Vial.tscn")
	var inst = vial.instance()
	$Place1.add_child(inst)
	inst = vial.instance()
	$Place2.add_child(inst)
	inst = vial.instance()
	$Place3.add_child(inst)
	inst = vial.instance()
	$Place4.add_child(inst)
	inst = vial.instance()
	$Place5.add_child(inst)
	inst = vial.instance()
	$Place6.add_child(inst)
	for i in 4:
		var j = 0
		while(j < 4):
			var ball = load("Ball.tscn")
			var instance = ball.instance()
			var color = rng.randi_range(0, 3)
			var colorname = Globals.colors[color]
			if(Globals.colors_dict[colorname]>0):
				instance.color = colorname
				Globals.colors_dict[colorname] = Globals.colors_dict[colorname]-1
				instance.vial = i
				instance.space = j
				Globals.vials[i].get_node("Space"+str(j)).add_child(instance)
				Globals.vials[i].balls.append(instance)
				j += 1
	finish = true
	#_randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(finish == true):
		var isFour = true
		for currentVial in Globals.vials:
			if(!(currentVial.balls.empty() || currentVial.balls.size()==4)):
				isFour = false
				return
		var same = true
		var checkedColors = []
		for currentVial in Globals.vials:
			if(!currentVial.balls.empty()):
				var currentBalls = currentVial.balls
				var currentColor = currentBalls[0].color
				if(!checkedColors.has(currentBalls[0].color)):
					checkedColors.append(currentBalls[0].color)
					for ball in currentBalls:
						if(ball.color != currentColor):
							same = false
							break
						else:
							same = true
					if(same == false):
						break
				else:
					same = false
			else:
				same = true
		if(same == true):
			print("Finish!")
			get_tree().paused = true
			$FinishedDialog.popup()
#	pass
func _randomize():
	var vialClass = Globals.vials[0]
	#for i in 30:
	rng.randomize()
	var source = rng.randi_range(0, 4)
	var target = rng.randi_range(0, 4)
	vialClass.changeAdminBall(Globals.vials[source], Globals.vials[target])

func _on_Exit_pressed():
	get_tree().free()

func _on_ButtonReload_pressed():
	Globals.musicStop = Music.get_playback_position()
	Globals.musicVol = $VolumeSlider.value
	get_tree().reload_current_scene()

func _on_FinishedDialog_confirmed():
	get_tree().paused = false
	get_tree().change_scene("res://Menu.tscn")

func _on_Rules_pressed():
	$RulesWindow.popup()
