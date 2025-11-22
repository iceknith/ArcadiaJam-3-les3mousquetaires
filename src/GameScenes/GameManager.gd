extends Node


var wave:int =0
var scoreThreshold:int = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	#afficheScore()
	
func afficheScore() -> void:
	PlayerVars.score += collect_coins()
	$PlayerScore.text = "score:" + str(PlayerVars.money)
	


func gameLoop() ->void:
	wave +=1
	PlayerVars.money = 0
	scoreThreshold = wave*6 # TODO 
	$Shop.restock()
	
	
	

func collect_coins() -> int:
	var coins = get_tree().get_nodes_in_group("coins")
	var total := 0.0

	for coin in coins:
		total += coin.value
		coin.queue_free()
	return total

func playRound() -> void:
	PlayerVars.money = collect_coins()

func _on_table_normale_shop() -> void:
	$Shop.visible = true
	$TableNormale.visible = false
	$TableTopdown.visible = false


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

func _on_table_topdown_round_finised() -> void:
	$Shop.visible = false
	$TableNormale.visible = true
	$TableTopdown.visible = false
	


func _on_shop_on_bought():
	$top_UI.refresh()
