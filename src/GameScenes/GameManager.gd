extends Node


var wave:int =0
var scoreThreshold:int = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gameLoop() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if PlayerVars.money >= scoreThreshold && PlayerVars.round == 0:
		PlayerVars.money -= scoreThreshold
		gameLoop()
	elif PlayerVars.round <= 0:
		gameOver()

func gameOver() -> void:
	#TODO MESSAGE GAME OVER / GAME OVER SCREEN
	pass

func gameLoop() ->void:
	wave +=1
	scoreThreshold = wave*2 # TODO 
	PlayerVars.debt = scoreThreshold
	$Shop.restock()
	$top_UI.refresh()

func collect_coins() -> float:
	var coins = get_tree().get_nodes_in_group("coins")
	var total = 0
	for coin in coins:
		if coin.resultat:
			total += coin.value
	return total
	

func playRound() -> void:
	PlayerVars.round-=1

func backToMenu() -> void:
	PlayerVars.money += collect_coins()
	$top_UI.refresh()

# SHOP
func _on_table_normale_shop() -> void:
	$Shop.visible = true
	$TableNormale.visible = false
	$TableTopdown.visible = false

#ENTER ROUND
func _on_table_normale_play() -> void:
	$Shop.visible = false
	$TableNormale.visible = false
	$TableTopdown.visible = true
	
	$Launch.launch()
	playRound()

func _on_shop_exit_shop():
	$Shop.visible = false
	$TableNormale.visible = true
	$TableTopdown.visible = false
	
	$top_UI.refresh()
	$TableNormale/delete_popup.hide()
	$TableNormale.update_pieces()

#EXIT ROUND
func _on_table_topdown_round_finised() -> void:
	$Shop.visible = false
	$TableNormale.visible = true
	$TableTopdown.visible = false
	$top_UI.refresh()
	backToMenu()
	


func _on_shop_on_bought():
	$top_UI.refresh()
