class_name piece extends Node

var organes:Dictionary = {
	"arm" : 2,
	"leg" : 2
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

var wave = 0
var money:int = 10

var score = 0
