extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	refresh()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func refresh():
	$Label.text = "Wave " + str(PlayerVars.wave) + "\n\nMoney : " + str(PlayerVars.money) + "\n\nDebt : " + str(PlayerVars.debt)
	$Label2.text = "Flip number : " + str(PlayerVars.organes["arm"]) + " (+" + str(PlayerVars.organes["tooth"]) + ")\n\nRound : " + str(PlayerVars.organes["leg"]) + "\n\nValue : " + str(PlayerVars.organes["liver"]*(2^PlayerVars.organes["lung"])) + "\n\nLuck : " + str(10*PlayerVars.organes["eye"]) + "%"
	$Container.load_organs()
