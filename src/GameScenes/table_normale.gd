extends Control

signal shop
signal play

var selected_piece = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_pieces()
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
	
	for coin:Button in pieces:
		coin.text = PlayerVars.pieces[i]
		i+=1


func _on_coin_1_toggled(toggled_on):
	var selected_piece = 1
	if PlayerVars.pieces[selected_piece-1] != "":
		$delete_coin.show()
		$delete_coin.global_position = $GridContainer/coin1.global_position + Vector2(-10,-10)
	else:
		$delete_coin.hide()


func _on_coin_2_toggled(toggled_on):
	selected_piece = 2
	if PlayerVars.pieces[selected_piece-1] != "":
		$delete_coin.show()
		$delete_coin.global_position = $GridContainer/coin2.global_position + Vector2(-10,-10)
	else:
		$delete_coin.hide()

func _on_coin_3_toggled(toggled_on):
	selected_piece = 3
	if PlayerVars.pieces[selected_piece-1] != "":
		$delete_coin.show()
		$delete_coin.global_position = $GridContainer/coin3.global_position + Vector2(-10,-10)
	else:
		$delete_coin.hide()


func _on_coin_4_toggled(toggled_on):
	selected_piece = 4
	if PlayerVars.pieces[selected_piece-1] != "":
		$delete_coin.show()
		$delete_coin.global_position = $GridContainer/coin4.global_position + Vector2(-10,-10)
	else:
		$delete_coin.hide()

func _on_coin_5_toggled(toggled_on):
	selected_piece = 5
	if PlayerVars.pieces[selected_piece-1] != "":
		$delete_coin.show()
		$delete_coin.global_position = $GridContainer/coin5.global_position + Vector2(-10,-10)
	else:
		$delete_coin.hide()


func _on_coin_6_toggled(toggled_on):
	selected_piece = 6
	if PlayerVars.pieces[selected_piece-1] != "":
		$delete_coin.show()
		$delete_coin.global_position = $GridContainer/coin6.global_position + Vector2(-10,-10)
	else:
		$delete_coin.hide()

func _on_delete_coin_pressed():
	$delete_popup.show()

func _on_confirm_pressed():
	PlayerVars.pieces[selected_piece-1] = ""
	update_pieces()
	$delete_popup.hide()
	$delete_coin.hide()


func _on_cancel_pressed():
	$delete_popup.hide()
