extends Control

signal shop
signal play


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_pieces()
	force_select_coin()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_play_button_pressed() -> void:
	play.emit()


func _on_shop_button_pressed() -> void:
	shop.emit()

func update_pieces():
	var pieces = $GridContainer.get_children()
	var i = 0
	var piece_name = ""
	
	for coin:Button in pieces:
		piece_name = PlayerVars.pieces[i]
		if piece_name != "":
			coin.tooltip_text= piece_name + " coin\nluck : " + str(PieceVars.pieces[piece_name]["luck"]) + "\nvalue : " + str(PieceVars.pieces[piece_name]["value"]) + "\ndurability : " + str(PlayerVars.pieces_durability[i])
			coin.get_node("TextureRect").show()
			coin.get_node("TextureRect").texture = load("res://assets/in-game/coin/coin_icon.png")
			coin.get_node("TextureRect").modulate = Color.hex(PieceVars.pieces[PlayerVars.pieces[i]]["color"])
		else:
			coin.tooltip_text = ""
			coin.get_node("TextureRect").hide()
		coin.disabled = PlayerVars.pieces[i] == ""
		i+=1


func _on_coin_1_toggled(toggled_on):
	PlayerVars.selectedPiece = 0
	if PlayerVars.pieces[PlayerVars.selectedPiece] != "":
		$delete_coin.show()
		$delete_coin.global_position = $GridContainer/coin1.global_position + Vector2(-10,-10)
		$PointLight2D.global_position = $GridContainer/coin1.global_position
	else:
		$delete_coin.hide()


func _on_coin_2_toggled(toggled_on):
	PlayerVars.selectedPiece = 1
	if PlayerVars.pieces[PlayerVars.selectedPiece] != "":
		$delete_coin.show()
		$delete_coin.global_position = $GridContainer/coin2.global_position + Vector2(-10,-10)
		$PointLight2D.global_position = $GridContainer/coin2.global_position
	else:
		$delete_coin.hide()

func _on_coin_3_toggled(toggled_on):
	PlayerVars.selectedPiece = 2
	if PlayerVars.pieces[PlayerVars.selectedPiece] != "":
		$delete_coin.show()
		$delete_coin.global_position = $GridContainer/coin3.global_position + Vector2(-10,-10)
		$PointLight2D.global_position = $GridContainer/coin3.global_position
	else:
		$delete_coin.hide()

func _on_coin_4_toggled(toggled_on):
	PlayerVars.selectedPiece = 3
	if PlayerVars.pieces[PlayerVars.selectedPiece] != "":
		$delete_coin.show()
		$delete_coin.global_position = $GridContainer/coin4.global_position + Vector2(-10,-10)
		$PointLight2D.global_position = $GridContainer/coin4.global_position
	else:
		$delete_coin.hide()

func _on_coin_5_toggled(toggled_on):
	PlayerVars.selectedPiece = 4
	if PlayerVars.pieces[PlayerVars.selectedPiece] != "":
		$delete_coin.show()
		$delete_coin.global_position = $GridContainer/coin5.global_position + Vector2(-10,-10)
		$PointLight2D.global_position = $GridContainer/coin5.global_position
	else:
		$delete_coin.hide()


func _on_coin_6_toggled(toggled_on):
	PlayerVars.selectedPiece = 5
	if PlayerVars.pieces[PlayerVars.selectedPiece] != "":
		$delete_coin.show()
		$delete_coin.global_position = $GridContainer/coin6.global_position + Vector2(-10,-10)
		$PointLight2D.global_position = $GridContainer/coin6.global_position
	else:
		$delete_coin.hide()

func _on_delete_coin_pressed():
	$delete_popup.show()

func _on_confirm_pressed():
	PlayerVars.pieces[PlayerVars.selectedPiece] = ""
	update_pieces()
	$delete_popup.hide()
	$delete_coin.hide()
	force_select_coin()

func _on_cancel_pressed():
	$delete_popup.hide()

func force_select_coin():
	var pieces = $GridContainer.get_children()
	var i = 0
	var piece_name = ""
	
	for coin:Button in pieces:
		if not coin.disabled:
			coin.button_pressed = true
			$delete_coin.show()
			$delete_coin.global_position = coin.global_position + Vector2(-10,-10)
			$PointLight2D.global_position = coin.global_position
			return
