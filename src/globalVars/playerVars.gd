class_name piece extends Node

var organes:Dictionary = {
	"arm" : 2,
	"leg" : 2,
	"tooth" : 0,
	"lung" : 1,
	"liver" : 0,
	"rib" : 0,
	"eye" : 2
}

var pieces:Array = [
	"yellow",
	"orange",
	"",
	"",
	"",
	""
]

var pieces_durability:Array = [
	-1,
	2,
	0,
	0,
	0,
	0
]

var bonus:Array = [
	
]

var selectedPiece:int = 0

func nb_piece() -> int:
	var count = 0
	for i in range(6):
		if (pieces[i]!=""):
			count+=1
	return count

var luck:float = 1


var wave:int = 0
var debt:int = 0
var round_left:int = 2
var money:float = 0

# multiplicateurs
var coin_multiplicateur = 1
# additionneur
var coin_additionneur = 0

var score = 0

var base_modifier = {
		"luck" : 1,
		"value" : 1
	}

func update_stat_organs():
	luck = pow(pow(1.1,organes["eye"]-2),base_modifier["luck"])
	coin_multiplicateur = base_modifier["value"] * max(0.5,organes["lung"]) #0.5 sans poumon 1 avec 1 et ensuite 2,3,4 etc
	coin_additionneur = organes["liver"]
