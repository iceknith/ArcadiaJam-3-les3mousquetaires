extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	refresh()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$AnimatedSprite2D.play("default")

func refresh():
	$money.text = str(PlayerVars.money) + " / " + str(PlayerVars.debt)
	if str(PlayerVars.round > 1):
		$round_left.text = str(PlayerVars.round) + " flips left"
	else:
		$round_left.text = "Last flip"
	
