class_name piece extends Node

var organes:Dictionary = {
	"arm" : 100,
	"leg" : 2,
	"tooth" : 0,
	"lung" : 2,
	"liver" : 1,
	"rib" : 0,
	"eye" : 2
}

var pieces:Array = [
	"yellow",
	"",
	"",
	"",
	"",
	""
]

var pieces_durability:Array = [
	-1,
	0,
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
var money:float = 100

# multiplicateurs
var coin_multiplicateur = 1
# additionneur
var coin_additionneur = 0

var score = 0

var base_modifier = {
		"luck" : 1,
		"value" : 0.5
	}

func update_stat_organs():
	luck = (1.1)^organes["eye"]
	coin_multiplicateur = 1 + organes["lung"]
	coin_additionneur = organes["liver"]
