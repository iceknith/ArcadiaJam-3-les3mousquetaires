class_name piece extends Node

var organes:Dictionary = {
	"arm" : 2,
	"leg" : 2,
	"tooth" : 0,
	"lung" : 2,
	"liver" : 1,
	"rib" : 0,
	"eye" : 2
}

var pieces:Array = [
	"yellow",
	"red",
	"red",
	"",
	"",
	""
]
var selectedPiece = pieces[0]

func nb_piece() -> int:
	var count = 0
	for i in range(6):
		if (pieces[i]!=""):
			count+=1
	return count

var wave:int = 0
var debt:int = 10
var round_left:int = 2
var money:int = 0

var score = 0
