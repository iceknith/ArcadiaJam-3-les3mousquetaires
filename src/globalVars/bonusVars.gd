extends Node

var bonus = {
	"arm" : {
		"type" : "organ",
		"weight" : 3
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
	"golden_body" : {
		"image" : "res://assets/in-game/bonus/tele.png",
		"desc" : "TON POID EN OR\n\n+1 coin per organs"
	},
	"random_organ" : {
		"image" : "res://assets/in-game/bonus/chainsaw.png",
		"desc" : "CHAINSAW\n\nbecome one with your flesh"
	},
	"invest_bonus" : { # +40% ou - 2% de ta thune en plus
		"image" : "res://assets/in-game/coin/coin_icon.png",
		"desc" : "GAMBLING???"
	},
	"double_or_nothing" : { # double ta thune ou suprime la!
		"image" : "res://assets/in-game/bonus/pigeon.png",
		"desc" : "DOUBLE OR NOTHING\n\n..."
	},
	"durabilite_coin" : { # fusion all of your coin intro one
		"image" : "res://icon.svg",
		"desc" : "GOLD!\n\nupgrade the durability of your current piece"
	},
	"super_coin" : { # UPGRADE your current coin
		"image" : "res://src/debugSprites/1euro.png",
		"desc" : "GOLD!\n\nupgrade your current pieces"
	},
	"horse" : { # HORSE
		"image" : "res://assets/in-game/bonus/horseHead.png",
		"desc" : "HORSE\n\nHorse, horse horse."
	}
	
}
