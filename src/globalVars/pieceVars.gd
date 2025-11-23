extends Node

var pieces:Dictionary = {
	"yellow" : {
		"effectPos" : "",
		"valuePos" : 1,
		"effectNeg" : "",
		"valueNeg" : 0,
		"price" : 0,
		"color" : 0xffff44ff,
		"luck" : 0.5,
		"dura" : -1
	},
	"purple" : {
		"effectPos" : "",
		"valuePos" : 0.5,
		"effectNeg" : "",
		"valueNeg" : 0,
		"price" : 0,
		"color" : 0x7a5eb8ff,
		"luck" : 0.8,
		"dura" : 1
	},
	"green" : {
		"effectPos" : "",
		"valuePos" : 10,
		"effectNeg" : "",
		"valueNeg" : 0,
		"price" : 1,
		"color" : 0x00a555ff,
		"luck" : 0.2,
		"dura" : 2
	},
	"blue" : {
		"effectPos" : "tooth",
		"valuePos" : 3,
		"effectNeg" : "",
		"valueNeg" : 0.3,
		"price" : 3,
		"color" : 0x00b2d1ff,
		"luck" : 0.7,
		"dura" : 1
	},
	"cyan" : {
		"effectPos" : "arm",
		"valuePos" : 0.5,
		"effectNeg" : "",
		"valueNeg" : 0,
		"price" : 2,
		"color" : 0x26e0beff,
		"luck" : 0.4,
		"dura" : 3
	},
	"orange" : {
		"effectPos" : "leg",
		"valuePos" : 2,
		"effectNeg" : "liver",
		"valueNeg" : -1,
		"price" : 2,
		"color" : 0xf29a3dff,
		"luck" : 0.4,
		"dura" : 3
	},
	"black" : {
		"effectPos" : "",
		"valuePos" : 10,
		"effectNeg" : "",
		"valueNeg" : -10,
		"price" : 2,
		"color" : 0x0a0a0aff,
		"luck" : 0.5,
		"dura" : 10
	},
	"red" : {
		"effectPos" : "",
		"valuePos" : 2,
		"effectNeg" : "",
		"valueNeg" : 0.5,
		"price" : 3,
		"color" : 0x2f1f1fff,
		"luck" : 0.6,
		"dura" : 3
	},
	"GOLD" : {
		"effectPos" : "",
		"valuePos" : 1000,
		"effectNeg" : "",
		"valueNeg" : 0,
		"price" : 8,
		"color" : 0xffd700ff,
		"luck" : 0.01,
		"dura" : 1 
	},
	"crimson" : {
		"effectPos" : "eye",
		"valuePos" : 3,
		"effectNeg" : "",
		"valueNeg" : -1,
		"price" : 0,
		"color" : 0xdc143cff,
		"luck" : 0.3,
		"dura" : 1 
	}#
}

func get_coin_tooltip(piece_name:String, dura_included:bool) -> String:
	var texte = piece_name + " coin"
	texte += "\nluck : " + str(pieces[piece_name]["luck"])
	
	if pieces[piece_name]["effectPos"] == "": texte += "\nvalue heads : " + str(pieces[piece_name]["valuePos"])
	else: texte += "\nvalue heads : " + str(pieces[piece_name]["valuePos"]) + " per " + pieces[piece_name]["effectPos"]
	
	if pieces[piece_name]["effectNeg"] == "":
		if pieces[piece_name]["valueNeg"] != 0: texte += "\nvalue tails : " + str(pieces[piece_name]["valuePos"])
	else: 
		texte += "\nvalue tails : " + str(pieces[piece_name]["valuePos"]) + " per " + pieces[piece_name]["effectNeg"]
	
	if dura_included: texte += "\n durability : " + str(PieceVars.pieces[piece_name]["dura"])

	return texte
