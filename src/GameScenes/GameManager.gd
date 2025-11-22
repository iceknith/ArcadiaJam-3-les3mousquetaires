extends Node

var base_rounds

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerVars.wave = 0
	$Info_popup.visible=false
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


func gameOver() -> void:
	#INFO POPUP
	$Info_popup.visible = true
	$Info_popup/Label.text = "GAME OVER"
	$Info_popup/popupTimer.wait_time = 99
	$Info_popup/popupTimer.start()
	pass

func new_wave()->void:
	PlayerVars.round_left = 3 + PlayerVars.organes["leg"]
	PlayerVars.wave +=1
	PlayerVars.debt = PlayerVars.wave*2 # TODO
	$top_UI.refresh()
	$Shop.restock()
	
	#INFO POPUP
	$Info_popup.visible = true
	if(PlayerVars.wave==1): $Info_popup/Label.text = "Let's play a game..."
	else: $Info_popup/Label.text = "NOUVELLE VAGUE"
	$Info_popup/popupTimer.wait_time = 2.5
	$Info_popup/popupTimer.start()



func collect_coins() -> float:
	var coins = get_tree().get_nodes_in_group("coins")
	var total = 0
	for coin in coins:
		if coin.resultat:
			total += coin.value
	return total
	

func playRound() -> void:
	PlayerVars.round_left-=1

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
	if check_selected_coin():
		$Shop.visible = false
		$TableNormale.visible = false
		$TableTopdown.visible = true
		
		$Launch.launch()
		playRound()

func check_selected_coin():
	return (PlayerVars.pieces[PlayerVars.selectedPiece]!="")


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


func _on_popup_timer_timeout() -> void:
	$Info_popup.visible = false
