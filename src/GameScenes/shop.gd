extends Control

signal exitShop
signal on_bought

var available_organs = [
	{"price" = 1, "name" = "arm"},
	{"price" = 2, "name" = "leg"},
	{},
	{},
	{}
	]
# [prix,nom]

var available_pieces = [
	{"price" = 1, "name" = "red"},
	{"price" = 2, "name" = "green"},
	{}
]

# Called when the node enters the scene tree for the first time.
func _ready():
	restock()
	update()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func update()->void:
	var i = 0
	var organ_slots = $Organcontainer.get_children()
	for slot:Button in organ_slots:
		if available_organs[i] != {}:
			slot.text = available_organs[i]["name"] + " :\n " + str(available_organs[i]["price"]) + "$"
		else:
			slot.text=""
		i+=1
	i=0
	var piece_slots = $Coincontainer.get_children()
	for slot:Button in piece_slots:
		if available_pieces[i] != {}:
			slot.text = available_pieces[i]["name"] + " :\n " + str(available_pieces[i]["price"]) + "$"
		else:
			slot.text=""
		i+=1


func restock() -> void:
	var i = 0
	var organ
	var organ_slots = $Organcontainer.get_children()
	for slot:Button in organ_slots:
		organ = get_random_organ()
		available_organs[i]["name"]= organ["name"]
		available_organs[i]["price"]= organ["price"]
		i+=1
	i=0
	
	var piece
	var piece_slots = $Coincontainer.get_children()
	for slot:Button in piece_slots:
		piece = get_random_piece()
		available_pieces[i]["name"]= piece["name"]
		available_pieces[i]["price"]= piece["price"]
		i+=1

func get_random_piece() -> Dictionary:
	return {
		"price" = 1, 
		"name" = "red"
		}


func get_random_organ() -> Dictionary:
	return {
		"name" : "arm",
		"image" : "",
		"icon" : "",
		"effect" : "",
		"value" : 1,
		"price" : 1
		}

func buy_organ(slot:int) -> void:
	if available_organs[slot] == {}:
		return
	if PlayerVars.money >= available_organs[slot]["price"]:
		#achat de l'organe
		PlayerVars.money -= available_organs[slot]["price"]
		PlayerVars.organes[available_organs[slot]["name"]] += 1
		
		print("+1 ",available_organs[slot]["name"],", vous avez :", PlayerVars.organes)
		available_organs[slot] = {}
		update()
	else:
		print("Pas assez d'argent")

func buy_piece(slot:int) -> void:
	if available_pieces[slot] == {}:
		return
	if PlayerVars.money >= available_pieces[slot]["price"]: #verif inventaire à ajouter
		#achat de la piece
		PlayerVars.money -= available_pieces[slot]["price"]
		ajouter_piece(available_pieces[slot]["name"])
		print("+1 piece ",available_pieces[slot]["name"])
		available_pieces[slot] = {}
		update()
	else:
		print("Pas assez d'argent")

func ajouter_piece(name:String) -> void:
	pass

func _on_slot_1_pressed():
	buy_organ(0)

func _on_slot_2_pressed():
	buy_organ(1)


func _on_slot_3_pressed():
	buy_organ(2)


func _on_slot_4_pressed():
	buy_organ(3)


func _on_slot_5_pressed():
	buy_organ(4)


func _on_coin_slot_1_pressed():
	buy_piece(0)


func _on_coin_slot_2_pressed():
	buy_piece(1)


func _on_coin_slot_3_pressed():
	buy_piece(2)
	

func _on_exit_button_pressed() -> void:
	exitShop.emit()
