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

func generate_selection() -> void:
	for i in range(3):
		var bonus = get_random_bonus()
		var malus = get_random_malus()
		var modifier = get_random_modifier()
		var artefact = get_random_artefact()
		available_choice[i] = {"bonus" : bonus, "malus" : malus, "modifier" : modifier, "artefact" : artefact}
	
	update_choice()
		

func update_choice() -> void:
	var i = 0
	var tooltip
	var dico
	var image
	var choices = $HBoxContainer.get_children()
	for choice:Button in choices:
		tooltip = ""
		dico = available_choice[i]
		image = choice.get_node("TextureRect")
		image.texture = load("res://assets/in-game/bgs/elements/journal.png")
		if dico["modifier"]["type"] == "add":
			tooltip += dico["artefact"]["nom"] + "\n\n"
			tooltip += "+ " + str(dico["bonus"]["weight"])+ " " + dico["bonus"]["on"]
			tooltip += "\nBut \n- " + str(dico["malus"]["weight"]) + " " + dico["malus"]["on"]
			
		if dico["modifier"]["type"] == "mult":
			tooltip += dico["artefact"]["nom"] + "\n\n"
			tooltip += "Double the " + dico["bonus"]["on"]
			tooltip += "\nBut \nHalves the " + dico["malus"]["on"]
		
		choice.tooltip_text = tooltip
		i+=1

func valider_choice(id):
	var dico = available_choice[id]
	print("modif",dico)
	if dico["modifier"]["type"] == "add":
		if dico["bonus"]["type"] == "organ":
			PlayerVars.organes[dico["bonus"]["on"]] += dico["bonus"]["weight"]
		elif dico["bonus"]["type"] == "money":
			PlayerVars.money += dico["bonus"]["weight"]
		elif dico["bonus"]["type"] == "modifier":
			pass
			
		if dico["malus"]["type"] == "organ":
			PlayerVars.organes[dico["malus"]["on"]] -= dico["malus"]["weight"]
		elif dico["malus"]["type"] == "money":
			PlayerVars.money -= dico["malus"]["weight"]
		elif dico["malus"]["type"] == "modifier":
			pass


	if dico["modifier"]["type"] == "mult":
		if dico["bonus"]["type"] == "organ":
			PlayerVars.organes[dico["bonus"]["on"]] = PlayerVars.organes[dico["bonus"]["on"]]*2
		elif dico["bonus"]["type"] == "money":
			PlayerVars.money = PlayerVars.money*2
		elif dico["bonus"]["type"] == "modifier":
			pass

		if dico["malus"]["type"] == "organ":
			PlayerVars.organes[dico["malus"]["on"]] = int(PlayerVars.organes[dico["malus"]["on"]] / 2)
		elif dico["malus"]["type"] == "money":
			PlayerVars.money = PlayerVars.money / 2
		elif dico["malus"]["type"] == "modifier":
			pass

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
