class_name piece extends Node

var organes:Dictionary = {
	"arm" : 2,
	"leg" : 2,
	"tooth" : 0,
	"lung" : 2,
	
}

var pieces:Array = [
	"red",
	"red",
	"red",
	"red",
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
var round:int = 5
var money:int = 10

var score = 0
