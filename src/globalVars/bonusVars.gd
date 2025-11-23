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
		"desc" : "TELEVISION\n\nDon't you know you're \nworth your weight in gold?\n\n+1 coin per organs"
	},
	"random_organ" : {
		"image" : "res://assets/in-game/bonus/chainsaw.png",
		"desc" : "CHAINSAW\n\nReady for a new look ?\nBecome one with your flesh"
	},
	"invest_bonus" : { # +40% ou - 2% de ta thune en plus
		"image" : "res://assets/in-game/coin/coin_icon.png",
		"desc" : "COIN\n\nReady to invest!\nYearn for the cash"
	},
	"double_or_nothing" : { # double ta thune ou suprime la!
		"image" : "res://assets/in-game/bonus/pigeon.png",
		"desc" : "BIRD\n\nDid you know 90% of gamblers \nquit just before they hit it big?\n..."
	},
	"durabilite_coin" : { # fusion all of your coin intro one
		"image" : "res://assets/in-game/bonus/logs.png",
		"desc" : "LOG\n\nUpgrade the durability \nof your coins\n+2 durability"
	},
	"super_coin" : { # UPGRADE your current coin
		"image" : "res://assets/in-game/bonus/mirror.png",
		"desc" : "MIRROR\n\nUpgrade the value of \nyour current coin"
	},
	"horse" : { # HORSE
		"image" : "res://assets/in-game/bonus/horseHead.png",
		"desc" : "HORSE\n\nHorse, horse horse."
	},
	"mirror" : { # HORSE
		"image" : "res://assets/in-game/bonus/mirror.png",
		"desc" : "MIRROR\n\ndouble your best organ at a cost"
	}
	
}
