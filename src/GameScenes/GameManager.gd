extends Node

#all vals
@export var base_rounds:int = 1
@export var debt_coeff:float = 0
@export var wave_multiplier = 1
var game_over = false

func _ready() -> void:
	PlayerVars.wave = 0
	$Info_popup.visible=false
	
	new_wave()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	connect_signals()

func connect_signals():
	$MusicPlayers/MusicPlayer.finished.connect(playSFX)
	$Shop/body_button.pressed.connect(view_body)
	$TableNormale/body_button.pressed.connect(view_body)
	$Bonus_menu/body_button.pressed.connect(view_body)
	$Player_list/body_button.pressed.connect(hide_body)

func _process(delta: float) -> void:
	#Move light to mouse
	var mousePos = get_viewport().get_mouse_position()
	mousePos.y = max(0, mousePos.y)
	$PointLight2D.global_position = mousePos
	$CursorHand.global_position = mousePos - $CursorHand/fingerMarker.position*$CursorHand.global_scale
	
	if Input.is_action_pressed("click"): $CursorHand.frame = 1
	else: $CursorHand.frame = 0
	
	
	if Input.is_action_just_pressed("ui_accept") && $TableNormale.visible && \
		!$TransitionPlayer.is_playing() && !$Player_list.visible && !$Bonus_menu.visible && !$Info_popup.visible:
			_on_table_normale_play()
	
	if Input.is_action_just_pressed("ui_accept") && $Shop.visible && \
		!$TransitionPlayer.is_playing() && !$Player_list.visible && !$Bonus_menu.visible && !$Info_popup.visible: 
			_on_shop_exit_shop()
	
	# Music
	#if !$MusicPlayers/MusicPlayer.playing && !$MusicPlayers/TapeSFX.playing:
	#	playSFX()

func gameloop():
	if game_over: return
	if PlayerVars.money >= PlayerVars.debt && PlayerVars.round_left == 0:
		$top_UI.buy_things(PlayerVars.debt)
		$Bonus_menu.show()
		$Bonus_menu.generate_selection()
	
func new_wave()->void:
	if game_over: return
	PlayerVars.round_left = max(base_rounds, PlayerVars.organes["leg"])
	if PlayerVars.wave == 0: PlayerVars.debt = 1
	else: 
		if PlayerVars.wave%5 == 1:
			wave_multiplier += 1
		PlayerVars.debt = PlayerVars.debt * wave_multiplier
	PlayerVars.wave +=1
	$top_UI.refresh()
	$Shop.restock()
	$TableNormale.update_pieces()
	var message =""
	if PlayerVars.wave==1:
		message = "NEW WAVE \n your debt is:\n"+str(PlayerVars.debt)+" coins"
	else:
		message = "WAVE"+str(PlayerVars.wave)+" \n your debt is:\n"+str(PlayerVars.debt)+" coins"
	afficherMessage(message)


func collect_coins() -> float:
	var coins = get_tree().get_nodes_in_group("coins")
	var total = 0
	for coin in coins:
		if coin.resultat: #PlayerVars.coin_multiplicateur + PlayerVars["organs"]["lung"]
			total += (coin.value+ PlayerVars.coin_additionneur) * PlayerVars.coin_multiplicateur 
	return total

func check_selected_coin():
	return (PlayerVars.pieces[PlayerVars.selectedPiece]!="")

func playRound() -> void:
	pass

func backToMenu() -> void:
	PlayerVars.round_left-=1
	PlayerVars.pieces_durability[PlayerVars.selectedPiece] -= 1
	if PlayerVars.pieces_durability[PlayerVars.selectedPiece] == 0:
		PlayerVars.pieces[PlayerVars.selectedPiece] = ""
		$TableNormale.force_select_coin()
		
	#PlayerVars.money += collect_coins()
	$TableNormale.update_pieces()
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
	elif PlayerVars.nb_piece() <= 0:
		gameOver()
	
	PlayerVars.update_stat_organs()


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
	
	backToMenu()
	gameloop()

func _on_shop_on_bought():
	$top_UI.refresh()

func afficherMessage(message:String)->void:
	$Info_popup/AnimationPlayer.play("infoPopUpShow")
	$Info_popup/Label.text = message

# SELECTION BONUS FIN WAVE ============================================


# GAME OVER ============================================
	
func gameOver() -> void:
	game_over = true
	print("GAME OVER !")
	$Info_popup.visible=true
	$Info_popup/AnimationPlayer.play("gameover_popup")
	var message = "GAME OVER"
	$Info_popup/Label.text = message


func restart_game() -> void:
	print("restart")
	PlayerVars.set_script(null)
	PlayerVars.set_script(preload("res://src/globalVars/playerVars.gd"))
	get_tree().reload_current_scene()


func _on_bonus_menu_exit():
	$top_UI.refresh()
	$Bonus_menu.hide()
	new_wave()


func playSFX():
	$MusicPlayers/TapeSFX.play(0)

# === View Body

func view_body():
	$Player_list.refresh()
	$TransitionPlayer2.play("playerListShow")

func hide_body():
	$TransitionPlayer2.play("playerListHide")
