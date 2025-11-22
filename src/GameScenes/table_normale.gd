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


func _on_coin_2_toggled(toggled_on):
	var selected_piece = 2
