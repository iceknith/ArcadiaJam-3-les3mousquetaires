extends Node

var bonus = {
	"arm" : {
		"type" : "organ",
		"weight" : 2
	},
	"leg" : {
		"type" : "organ",
		"weight" : 2
	},
	"tooth" : {
		"type" : "organ",
		"weight" : 10
	},
	"lung" : {
		"type" : "organ",
		"weight" : 1
	},
	"liver" : {
		"type" : "organ",
		"weight" : 1
	},
	"coin" : {
		"type" : "money",
		"weight" : 5
	},
	"coin2" : {
		"type" : "money",
		"weight" : 8
	},
	"coin3" : {
		"type" : "money",
		"weight" : 3
	},
	"luck" : {
		"type" : "modifier",
		"weight" : 0.1
	}
}

var modifiers = [
	"mult",
	"add"
]


var artefacts = {
	"WATERING CAN" : "res://assets/in-game/bonus/watering_can.png",
	"SPACE PISTOL" : "res://assets/in-game/bonus/space-pistol.png",
	"PISTOL" : "res://assets/in-game/bonus/pistol.png",
	"DUCKY" : "res://assets/in-game/bonus/ducky.png",
	"PUPPET" : "res://assets/in-game/bonus/elmo.png"
}

var special = {
	"nom" : "",
	"texte" : ""
}
