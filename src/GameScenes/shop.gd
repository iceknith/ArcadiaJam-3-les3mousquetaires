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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func update()->void:
	on_bought.emit()
	var i = 0
	var organ_slots = $Organcontainer.get_children()
	for slot:Button in organ_slots:
		if available_organs[i] != {}:
			slot.tooltip_text = available_organs[i]["name"] + "\n " + OrganVars.organs[available_organs[i]["name"]]["desc"] + "\n " + str(available_organs[i]["price"]) + "$"
			slot.get_node("TextureRect").show()
			slot.get_node("TextureRect").texture = load(OrganVars.organs[available_organs[i]["name"]]["image"])
			slot.disabled = false
		else:
			slot.tooltip_text=""
			slot.get_node("TextureRect").hide()
			slot.disabled = true
		i+=1
	i=0
	var piece_slots = $Coincontainer.get_children()
	var piece_name = ""
	for slot:Button in piece_slots:
		if available_pieces[i] != {}:
			piece_name = available_pieces[i]["name"]
			slot.tooltip_text = PieceVars.get_coin_tooltip(piece_name, true) + "\n " + str(available_pieces[i]["price"]) + "$"
			slot.get_node("TextureRect").show()
			slot.get_node("TextureRect").texture = load("res://assets/in-game/coin/coin_icon.png")
			slot.get_node("TextureRect").modulate = Color.hex(PieceVars.pieces[piece_name]["color"])
			slot.disabled = false
		else:
			slot.tooltip_text=""
			slot.get_node("TextureRect").hide()
			slot.disabled = true
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
	
	update()

func get_random_piece() -> Dictionary:
	var piece_name = "yellow"
	while (piece_name == "yellow"):
		piece_name = PieceVars.pieces.keys()[randi_range(0,PieceVars.pieces.size()-1)]
	var piece = PieceVars.pieces[piece_name]
	piece["name"] = piece_name
	return piece


func get_random_organ() -> Dictionary:
	var organ_name = OrganVars.organs.keys()[randi_range(0,OrganVars.organs.size()-1)]
	var organ = OrganVars.organs[organ_name]
	organ["name"] = organ_name
	return organ


func buy_organ(slot:int) -> void:
	if available_organs[slot] == {}:
		return
	if PlayerVars.money >= available_organs[slot]["price"]:
		#achat de l'organe
		get_tree().get_first_node_in_group("UI").buy_things(available_organs[slot]["price"])
		PlayerVars.organes[available_organs[slot]["name"]] += 1
		if available_organs[slot]["name"] == "leg":
			PlayerVars.round_left+=1
		print("+1 ",available_organs[slot]["name"],", vous avez :", PlayerVars.organes)
		available_organs[slot] = {}
		update()
	else:
		print("Pas assez d'argent")

func buy_piece(slot:int) -> void:
	if available_pieces[slot] == {}:
		return
	if PlayerVars.money >= available_pieces[slot]["price"]:
		if PlayerVars.nb_piece() < 6: #verif inventaire à ajouter
		#achat de la piece
			get_tree().get_first_node_in_group("UI").buy_things(available_pieces[slot]["price"])
			ajouter_piece(available_pieces[slot]["name"])
			print("+1 piece ",available_pieces[slot]["name"],", vous avez : ",PlayerVars.pieces)
			available_pieces[slot] = {}
			update()
		else:
			print("Inventaire plein")
	else:
		print("Pas assez d'argent")

func ajouter_piece(name:String) -> void:
	for i in range(6):
		if PlayerVars.pieces[i] == "":
			PlayerVars.pieces[i] = name
			PlayerVars.pieces_durability[i] = PieceVars.pieces[name]["dura"]
			return

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
