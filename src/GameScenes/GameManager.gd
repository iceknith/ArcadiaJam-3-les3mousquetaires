extends Node

#all vals
var base_rounds
var game_over = false

func _ready() -> void:
	PlayerVars.wave = 0
	$Info_popup.visible=false
	$Info_popup/HBoxContainer.visible = false
	$Info_popup/Restart.visible=false
	
	new_wave()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _process(delta: float) -> void:
	#Move light to mouse
	var mousePos = get_viewport().get_mouse_position()
	mousePos.y = max(0, mousePos.y)
	$PointLight2D.global_position = mousePos
	$CursorHand.global_position = mousePos - $CursorHand/fingerMarker.position*$CursorHand.global_scale
	
	if Input.is_action_pressed("click"): $CursorHand.frame = 1
	else: $CursorHand.frame = 0
	
	

func gameloop():
	if game_over: return
	if PlayerVars.money >= PlayerVars.debt && PlayerVars.round_left == 0:
		PlayerVars.money -= PlayerVars.debt
		bonusSelection()

	
func new_wave()->void:
	if game_over: return
	PlayerVars.round_left = PlayerVars.organes["leg"]
	PlayerVars.wave +=1
	PlayerVars.debt = PlayerVars.wave*2 # TODO
	$top_UI.refresh()
	$Shop.restock()

	var message = "NEW WAVE \n your dept is :"+str(PlayerVars.debt)+" pieces"
	afficherMessage(message)


func collect_coins() -> float:
	var coins = get_tree().get_nodes_in_group("coins")
	var total = 0
	for coin in coins:
		if coin.resultat:
			total += coin.value
	return total

func check_selected_coin():
	return (PlayerVars.pieces[PlayerVars.selectedPiece]!="")

func playRound() -> void:
	PlayerVars.round_left-=1

func backToMenu() -> void:
	PlayerVars.money += collect_coins()
	$top_UI.refresh()
	if PlayerVars.money < PlayerVars.debt && PlayerVars.round_left <= 0 && !game_over:
		gameOver()

# MAIN UI ELMENTS ============================================

# SHOP
func _on_table_normale_shop() -> void:
	if game_over: return
	$Shop.visible = true
	$TransitionPlayer.play("shopLaunch")

#ENTER ROUND
func _on_table_normale_play() -> void:
	if check_selected_coin():
		$Shop.visible = false
		$TransitionPlayer.play("topDownLaunch")
		
		$TableTopdown/Launch.launch()
		playRound()


func _on_shop_exit_shop():
	if game_over: return
	$Shop.visible = false
	$TransitionPlayer.play("shopStop")
	
	$top_UI.refresh()
	$TableNormale/delete_popup.hide()
	$TableNormale.update_pieces()

#EXIT ROUND
func _on_table_topdown_round_finised() -> void:
	$Shop.visible = false
	$TransitionPlayer.play("topDownStop")
	
	$top_UI.refresh()
	backToMenu()
	
	gameloop()

func _on_shop_on_bought():
	$top_UI.refresh()

func afficherMessage(message:String)->void:
	$Info_popup/AnimationPlayer.play("infoPopUpShow")
	$Info_popup/Label.text = message

# SELECTION BONUS FIN WAVE ============================================
var bouton_1_bonus


func _on_choix_1_pressed() -> void:
	print("option 1 chosie")
	exitBonusSelection()


func _on_choix_2_pressed() -> void:
	print("option 2 chosie")
	exitBonusSelection()


func _on_choix_3_pressed() -> void:
	print("option 3 chosie")
	exitBonusSelection()

func bonusSelection() ->void:
	new_wave()
	$Info_popup/AnimationPlayer.play("gameover_popup")
	$Info_popup/Label.text = "DEBUG"
	$Info_popup.visible = true
	$Info_popup/HBoxContainer.visible=true
	
	#var bonus = $Info_popup/HBoxContainer.get_children()
	#for slot:Button in bonus:
	#	slot.get_node("TextureRect").texture = load(BonusVars.bonus[available_organs[i]["name"]]["image"])




func exitBonusSelection() ->void:
	$Info_popup.visible = false
	$Info_popup/HBoxContainer.visible=false

# GAME OVER ============================================
	
func gameOver() -> void:
	game_over = true
	print("GAME OVER !")
	$Info_popup.visible=true
	$Info_popup/Restart.visible=true
	$Info_popup/HBoxContainer.visible=false
	$Info_popup/AnimationPlayer.play("gameover_popup")
	var message = "GAME OVER"
	$Info_popup/Label.text = message
	
func _on_restart_pressed() -> void:
	load("res://src/GameScenes/main_game.tscn")
