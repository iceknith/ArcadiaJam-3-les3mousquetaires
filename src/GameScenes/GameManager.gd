extends Node

var base_rounds
var game_over = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerVars.wave = 0
	$Info_popup.visible=false
	new_wave()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#Move light to mouse
	$PointLight2D.global_position = get_viewport().get_mouse_position()


func gameloop():
	if game_over: return
	if PlayerVars.money >= PlayerVars.debt && PlayerVars.round_left == 0:
		PlayerVars.money -= PlayerVars.debt
		bonusSelection()
	elif PlayerVars.money < PlayerVars.debt && PlayerVars.round_left <= 0:
		gameOver()


func gameOver() -> void:
	var message = "GAME OVER"
	game_over = true
	afficherMessage(message,99)
	
func new_wave()->void:
	PlayerVars.round_left = PlayerVars.organes["leg"]
	PlayerVars.wave +=1
	PlayerVars.debt = PlayerVars.wave*2 # TODO
	$top_UI.refresh()
	$Shop.restock()
	
	#INFO POPUP
	var message = "NEW WAVE \n your debt is :"+str(PlayerVars.debt)+" pieces"
	afficherMessage(message,2)


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
	if game_over: return
	$Shop.visible = true
	#$TableNormale.visible = false
	#$TableTopdown.visible = false
	$TransitionPlayer.play("shopLaunch")

#ENTER ROUND
func _on_table_normale_play() -> void:
	if check_selected_coin():
		$Shop.visible = false
		#$TableNormale.visible = false
		#$TableTopdown.visible = true
		$TransitionPlayer.play("topDownLaunch")
		
		$TableTopdown/Launch.launch()
		playRound()

func check_selected_coin():
	return (PlayerVars.pieces[PlayerVars.selectedPiece]!="")


func _on_shop_exit_shop():
	if game_over: return
	$Shop.visible = false
	#$TableNormale.visible = true
	#$TableTopdown.visible = false
	$TransitionPlayer.play("shopStop")
	
	$top_UI.refresh()
	$TableNormale/delete_popup.hide()
	$TableNormale.update_pieces()

#EXIT ROUND
func _on_table_topdown_round_finised() -> void:
	$Shop.visible = false
	#$TableNormale.visible = true
	#$TableTopdown.visible = false
	$TransitionPlayer.play("topDownStop")
	
	$top_UI.refresh()
	backToMenu()
	
	gameloop()

func _on_shop_on_bought():
	$top_UI.refresh()

func afficherMessage(message:String,time:float)->void:
	$Info_popup/AnimationPlayer.play("infoPopUpShow")
	$Info_popup/Label.text = message

# SELECTION FIN WAVE

func _on_choix_1_pressed() -> void:
	print("option 1 chosie")
	exitBonusSelection()
	pass # Replace with function body.


func _on_choix_2_pressed() -> void:
	print("option 2 chosie")
	exitBonusSelection()
	pass # Replace with function body.


func _on_choix_3_pressed() -> void:
	print("option 3 chosie")
	exitBonusSelection()
	pass # Replace with function body.

func bonusSelection() ->void:
	$Info_popup.visible = true
	$Info_popup/HBoxContainer.visible=true

func exitBonusSelection() ->void:
	$Info_popup.visible = false
	$Info_popup/HBoxContainer.visible=false
	new_wave()
	
