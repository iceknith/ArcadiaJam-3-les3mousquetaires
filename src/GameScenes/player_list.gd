extends Control

var initText:String
var initText2:String

# Called when the node enters the scene tree for the first time.
func _ready():
	initText = $Label.text
	initText2 = $Label2.text
	refresh()


func refresh():
	#$Label.text = "Wave " + str(PlayerVars.wave) + "\n\nMoney : " + str(PlayerVars.money) + "\n\nDebt : " + str(PlayerVars.debt)
	#$Label2.text = "Flip number : " + str(PlayerVars.organes["arm"]) + " (+" + str(PlayerVars.organes["tooth"]) + ")\n\nRound : " + str(PlayerVars.organes["leg"]) + "\n\nValue : " + str(PlayerVars.organes["liver"]*(2^PlayerVars.organes["lung"])) + "\n\nLuck : " + str(10*PlayerVars.organes["eye"]) + "%"
	PlayerVars.update_stat_organs()
	setText()
	$ScrollContainer/MarginContainer/Container.load_organs()

func setText():
	$Label.text = initText
	$Label.text = $Label.text.replace("$WaveNumber", str(PlayerVars.wave))
	$Label.text = $Label.text.replace("$Money", str(PlayerVars.money))
	$Label.text = $Label.text.replace("$Debt", str(PlayerVars.debt))
	$Label.text = $Label.text.replace("$Flips", str(PlayerVars.organes["arm"]) + " (+" + str(PlayerVars.organes["tooth"]) + ")") 
	$Label.text = $Label.text.replace("$Rounds", str(PlayerVars.organes["leg"]))
	
	$Label2.text = initText2
	$Label2.text = $Label2.text.replace("$CoinMult", str(PlayerVars.coin_multiplicateur))
	$Label2.text = $Label2.text.replace("$CoinAdd", str(PlayerVars.coin_additionneur))
	$Label2.text = $Label2.text.replace("$Luck", str(PlayerVars.luck))
