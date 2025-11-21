extends Control


signal on_bought

var available_organs = [
	{"price" = 1, "name" = "arm"},
	{"price" = 2, "name" = "leg"},
	{},
	{},
	{}
	]
# [prix,nom]

# Called when the node enters the scene tree for the first time.
func _ready():
	restock()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func restock():
	var organ
	var i = 0
	var organ_slots = $Organcontainer.get_children()
	for slot:Button in organ_slots:
		organ = get_random_organ()
		available_organs[i]["name"]= organ["name"]
		available_organs[i]["price"]= organ["price"]
		slot.text = organ["name"] + " : " + str(organ["price"]) + "$"
		i+=1


func get_random_organ():
	return {
		"name" : "arm",
		"image" : "",
		"icon" : "",
		"effect" : "",
		"value" : 1,
		"price" : 1
		}

func buy_organ(slot):
	pass



func _on_slot_1_pressed():
	#buy_organ(0)
	if PlayerVars.pieces >= available_organs[0]["price"]:
		#achat de l'organe
		PlayerVars.pieces -= available_organs[0]["price"]
		PlayerVars.organes[available_organs[0]["name"]] += 1
		print(PlayerVars.organes)
	else:
		print("Pas assez d'argent")
