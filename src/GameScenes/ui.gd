extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	refresh()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$AnimatedSprite2D.play("default")

func refresh():
	$money.text = str(PlayerVars.money) + " / " + str(PlayerVars.debt)
	if PlayerVars.round_left > 1:
		$round_left.text = str(PlayerVars.round_left) + " flips left"
	else:
		$round_left.text = "Last flip"
	
