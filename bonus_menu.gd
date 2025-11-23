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
	var random
	for i in range(3):
		random = randi()%2
		if random<1 : 
			var bonus = get_random_bonus()
			var malus = get_random_malus()
			while bonus["on"] == malus["on"]:
				malus = get_random_malus()
			var modifier = get_random_modifier()
			var artefact = get_random_artefact()
			available_choice[i] = {"bonus" : bonus, "malus" : malus, "modifier" : modifier, "artefact" : artefact, "type" : "normal"}
		else: #special_choice
			available_choice[i] = get_random_special()
	update_choice()

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
				PlayerVars.base_modifier[dico["malus"]["on"]] = max(1,PlayerVars.base_modifier[dico["bonus"]["on"]],dico["malus"]["weight"]) 


		if dico["modifier"]["type"] == "mult":
			if dico["bonus"]["type"] == "organ":
				PlayerVars.organes[dico["bonus"]["on"]] = PlayerVars.organes[dico["bonus"]["on"]]*2
			elif dico["bonus"]["type"] == "money":
				get_tree().get_first_node_in_group("UI").set_money(PlayerVars.money * 2)
			elif dico["bonus"]["type"] == "modifier":
				PlayerVars.base_modifier[dico["bonus"]["on"]] = PlayerVars.base_modifier[dico["bonus"]["on"]] * 2

			if dico["malus"]["type"] == "organ":
				PlayerVars.organes[dico["malus"]["on"]] = int(PlayerVars.organes[dico["malus"]["on"]] / 2)
			elif dico["malus"]["type"] == "money":
				get_tree().get_first_node_in_group("UI").set_money(PlayerVars.money / 2)
			elif dico["malus"]["type"] == "modifier":
				PlayerVars.base_modifier[dico["malus"]["on"]] = PlayerVars.base_modifier[dico["malus"]["on"]] / 2
	else:
		if dico["nom"] == "golden_body":
			golden_body()

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
	var money = 0
	for organs in PlayerVars.organes:
		money += PlayerVars.organes[organs] 
	get_tree().get_first_node_in_group("UI").set_money(money + PlayerVars.money)
	
	
func random_organ() -> void:
	var nb_organs = 0
	for organs in PlayerVars.organes:
		nb_organs += PlayerVars.organes[organs]
	
	var random_organ
	for i in range(nb_organs):
		random_organ = OrganVars.organs[OrganVars.organs.keys()[OrganVars.organs.size()]]
		print(random_organ)
		
	
	
