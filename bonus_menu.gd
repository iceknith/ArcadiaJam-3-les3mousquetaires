extends Control

signal exit

var available_choice:Array = [[], [], []]


# Called when the node enters the scene tree for the first time.
func _ready():
	generate_selection()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_random_bonus() -> Dictionary: #{"on" : "arm", "weight" : 2}
	var bonus_name = BonusVars.bonus.keys()[randi_range(0,BonusVars.bonus.size()-1)]
	return {"on" : bonus_name,"type" : BonusVars.bonus[bonus_name]["type"], "weight" : BonusVars.bonus[bonus_name]["weight"]}

func get_random_malus() -> Dictionary: #{"on" : "arm", "weight" : 2} same que bonus
	var bonus_name = BonusVars.bonus.keys()[randi_range(0,BonusVars.bonus.size()-1)]
	return {"on" : bonus_name,"type" : BonusVars.bonus[bonus_name]["type"], "weight" : BonusVars.bonus[bonus_name]["weight"]}

func get_random_modifier() -> Dictionary: #{"type" : "mult"}
	var mod_type = BonusVars.modifiers[randi_range(0,BonusVars.modifiers.size()-1)]
	return {"type" : mod_type}
	
func get_random_artefact() -> Dictionary: #{"nom" : "arrosoir", "image" : "src//"}
	var artefact_name = BonusVars.artefacts.keys()[randi_range(0,BonusVars.artefacts.size()-1)]
	return {"nom" : artefact_name, "image" : BonusVars.artefacts[artefact_name]}

func get_random_special() -> Dictionary:
	var special_name = BonusVars.special.keys()[randi_range(0,BonusVars.special.size()-1)]
	return {"type" : "special", "nom" : special_name, "image" : BonusVars.special[special_name]["image"], "desc" : BonusVars.special[special_name]["desc"]}

func generate_selection() -> void:
	for i in range(3):
		if randf()>0.33 :
			var bonus = get_random_bonus()
			var malus = get_random_malus()
			while bonus["on"] == malus["on"]:
				malus = get_random_malus()
			var modifier
			if randf()>0.7:
				modifier = {"type" : "mult"}
			else :
				modifier = {"type" : "add"}

			var artefact = get_random_artefact()
			available_choice[i] = {"bonus" : bonus, "malus" : malus, "modifier" : modifier, "artefact" : artefact, "type" : "normal"}
		else: #special_choice
			available_choice[i] = get_random_special()
	update_choice()
	$money.text = str(PlayerVars.money) + "    "

func update_choice() -> void:
	var i = 0
	var tooltip:String
	var nom:String
	var dico:Dictionary
	var image
	var choices = $HBoxContainer.get_children()
	for choice:Button in choices:
		tooltip = ""
		dico = available_choice[i]
		if dico["type"] == "normal":
			image = choice.get_node("TextureRect")
			image.texture = load(dico["artefact"]["image"])
			if dico["modifier"]["type"] == "add":
				tooltip += dico["artefact"]["nom"] + "\n\n"
				tooltip += "+ " + str(dico["bonus"]["weight"])+ " "
				nom = dico["bonus"]["on"]
				if nom.left(4) == "coin":
					tooltip += "coin"
				else:
					tooltip += dico["bonus"]["on"]
				tooltip += "\nBut \n- " + str(dico["malus"]["weight"]) + " "
				nom = dico["malus"]["on"]
				if nom.left(4) == "coin":
					tooltip += "coin"
				else:
					tooltip += nom
		
			if dico["modifier"]["type"] == "mult":
				tooltip += dico["artefact"]["nom"] + "\n\n"
				tooltip += "Double the " 
				nom = dico["bonus"]["on"]
				if nom.left(4) == "coin":
					tooltip += "coin"
				else:
					tooltip+=nom
				tooltip += "\nBut \nHalves the "
				nom = dico["malus"]["on"]
				if nom.left(4) == "coin":
					tooltip += "coin"
				else:
					tooltip += nom
		else:
			tooltip = dico["desc"]
			image = choice.get_node("TextureRect")
			image.texture = load(dico["image"])
		
		choice.tooltip_text = tooltip
		i+=1

func valider_choice(id):
	var dico = available_choice[id]
	print("modif",dico)
	if dico["type"] == "normal":
		if dico["modifier"]["type"] == "add":
			if dico["bonus"]["type"] == "organ":
				PlayerVars.organes[dico["bonus"]["on"]] += dico["bonus"]["weight"]
			elif dico["bonus"]["type"] == "money":
				get_tree().get_first_node_in_group("UI").set_money(PlayerVars.money + dico["bonus"]["weight"])
			elif dico["bonus"]["type"] == "modifier":
				PlayerVars.base_modifier[dico["bonus"]["on"]] += dico["bonus"]["weight"]
				
			if dico["malus"]["type"] == "organ":
				PlayerVars.organes[dico["malus"]["on"]] -= dico["malus"]["weight"]
				if PlayerVars.organes[dico["malus"]["on"]]<0:
					PlayerVars.organes[dico["malus"]["on"]]=0
			elif dico["malus"]["type"] == "money":
				get_tree().get_first_node_in_group("UI").set_money(PlayerVars.money - dico["malus"]["weight"])
			elif dico["malus"]["type"] == "modifier":
				PlayerVars.base_modifier[dico["malus"]["on"]] = max(1,PlayerVars.base_modifier[dico["malus"]["on"]],dico["malus"]["weight"]) 


		if dico["modifier"]["type"] == "mult":
			if dico["bonus"]["type"] == "organ":
				PlayerVars.organes[dico["bonus"]["on"]] = PlayerVars.organes[dico["bonus"]["on"]]*2
			elif dico["bonus"]["type"] == "money":
				get_tree().get_first_node_in_group("UI").set_money(PlayerVars.money * 2)
			elif dico["bonus"]["type"] == "modifier":
				PlayerVars.base_modifier[dico["bonus"]["on"]] = PlayerVars.base_modifier[dico["bonus"]["on"]] * 2

			if dico["malus"]["type"] == "organ":
				PlayerVars.organes[dico["malus"]["on"]] = int(PlayerVars.organes[dico["malus"]["on"]] / 2 + 0.5)
			elif dico["malus"]["type"] == "money":
				get_tree().get_first_node_in_group("UI").set_money(PlayerVars.money / 2)
			elif dico["malus"]["type"] == "modifier":
				PlayerVars.base_modifier[dico["malus"]["on"]] = PlayerVars.base_modifier[dico["malus"]["on"]] / 2
	else:
		if dico["nom"] == "golden_body":
			golden_body()
		if dico["nom"] == "random_organ":
			random_organ()
		if dico["nom"] == "invest_bonus":
			invest_bonus()
		if dico["nom"] == "durabilite_coin":
			durabilite_coin()
		if dico["nom"] == "super_coin":
			super_coin()
		if dico["nom"] == "double_or_nothing":
			double_or_nothing()
		if dico["nom"] == "horse":
			horse()
		if dico["nom"] == "mirror":
			mirror()
		if dico["nom"] == "midas":
			midas()

	exit.emit()


func _on_choix_1_pressed() -> void:
	print("option 1 chosie")
	valider_choice(0)


func _on_choix_2_pressed() -> void:
	print("option 2 chosie")
	valider_choice(1)


func _on_choix_3_pressed() -> void:
	print("option 3 chosie")
	valider_choice(2)
	
func golden_body() -> void:
	print("golden_body")
	var money = 0
	for organs in PlayerVars.organes:
		money += PlayerVars.organes[organs] 
	get_tree().get_first_node_in_group("UI").set_money(PlayerVars.money + money)
	
	
func random_organ() -> void:
	print("random_organ")
	var nb_organs = 0
	for organs in PlayerVars.organes:
		nb_organs += PlayerVars.organes[organs]
		PlayerVars.organes[organs] = 0

	var random_organ
	for i in range(nb_organs):
		random_organ = OrganVars.organs.keys()[randi_range(0,OrganVars.organs.size()-1)]
		print(random_organ)
		PlayerVars.organes[random_organ] += 1

func invest_bonus() -> void:
	print("invest_bonus")
	if(randf()>0.2):
		get_tree().get_first_node_in_group("UI").set_money(PlayerVars.money*1.4)
	else:
		get_tree().get_first_node_in_group("UI").set_money(0.1)

func durabilite_coin() -> void:
	print("durabilite_coin")
	var i = 0
	for piece_name in PlayerVars.pieces:
		if piece_name != "" and piece_name != "yellow":
			PlayerVars.pieces_durability[i] += 2
			i+=1
	
func super_coin() -> void:
	print("yellow++")
	PieceVars.pieces["yellow"]["valuePos"] = roundf(10 * PieceVars.pieces["yellow"]["valuePos"] * (1+randf()))/10

func horse() -> void:
	print("horse")
	PlayerVars.horse = true
	PlayerVars.luck+=0.2


func double_or_nothing() -> void:
	if randi() == 1:
		get_tree().get_first_node_in_group("UI").set_money(PlayerVars.money + PlayerVars.money)
	else:
		get_tree().get_first_node_in_group("UI").set_money(0)

func mirror() -> void:
	print("mirror")
	var organ_max = "arm"
	for organ in OrganVars.organs.keys():
		if PlayerVars.organes[organ] >= PlayerVars.organes[organ_max]:
			organ_max = organ
	PlayerVars.organes[organ_max] = PlayerVars.organes[organ_max] * 2
	PlayerVars.base_modifier["luck"] = PlayerVars.base_modifier["luck"]/2

func midas() -> void:
	var  random_piece
	for i in range(6):
		random_piece = PieceVars.pieces.keys()[randi_range(0,PieceVars.pieces.size()-1)]
		PlayerVars.pieces[i] = random_piece
		PlayerVars.pieces_durability[i] = PieceVars.pieces[random_piece]["dura"]
