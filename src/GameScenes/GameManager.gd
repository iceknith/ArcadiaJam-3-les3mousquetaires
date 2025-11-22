extends Node

var wave:int 
var scoreThreshold:int = 10



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	



func collect_coins() -> int:
	var coins = get_tree().get_nodes_in_group("coins")
	var total := 0.0

	for coin in coins:
		total += coin.value
		coin.queue_free()
	return total


func _on_table_normale_shop() -> void:
	$Shop.visible = true
	$TableNormale.visible = false
	$TableTopdown.visible = false


func _on_table_normale_play() -> void:
	$Shop.visible = false
	$TableNormale.visible = false
	$TableTopdown.visible = true
	
	$Launch.launch()

func _on_shop_exit_shop():
	$Shop.visible = false
	$TableNormale.visible = true
	$TableTopdown.visible = false
	
	$top_UI.refresh()
	$TableNormale/delete_popup.hide()
	$TableNormale.update_pieces()
	


func _on_shop_on_bought():
	$top_UI.refresh()
