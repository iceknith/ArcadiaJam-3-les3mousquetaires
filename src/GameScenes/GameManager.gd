extends Node

var base_rounds

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerVars.wave = 0
	new_wave()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	gameloop()


func gameloop():
	if PlayerVars.money >= PlayerVars.debt && PlayerVars.round_left == 0:
		PlayerVars.money -= PlayerVars.debt
		new_wave()
	elif PlayerVars.round_left <= 0:
		gameOver()

	if PlayerVars.money > 999:
		win()

func gameOver() -> void:
	#TODO MESSAGE GAME OVER / GAME OVER SCREEN
	pass

func new_wave()->void:
	PlayerVars.round_left = 3 + PlayerVars.organes["leg"]
	PlayerVars.wave +=1
	PlayerVars.debt = PlayerVars.wave*2 # TODO
	$top_UI.refresh()
	$Shop.restock()

func win()->void:
	pass



func collect_coins() -> int:
	var coins = get_tree().get_nodes_in_group("coins")
	var total := 0.0

	for coin in coins:
		total += coin.value
		coin.queue_free()
	return total

func playRound() -> void:
	PlayerVars.round_left-=1

func backToMenu() -> void:
	$top_UI.refresh()
	PlayerVars.money += collect_coins()

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
