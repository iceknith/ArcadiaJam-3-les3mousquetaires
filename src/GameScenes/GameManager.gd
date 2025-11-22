extends Node

var wave:int 
var scoreThreshold:int = 10



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	afficheScore()
	
func afficheScore() -> void:
	PlayerVars.score += collect_coins()
	$PlayerScore.text = "score:" + str(PlayerVars.score) + "/" + str(scoreThreshold) + "\n" + "money:"+str(PlayerVars.money)


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
	
	$TableNormale/delete_popup.hide()
	$TableNormale.update_pieces()
