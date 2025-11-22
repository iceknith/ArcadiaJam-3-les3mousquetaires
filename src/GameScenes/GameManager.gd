extends Node

var wave:int 
var scoreThreshold:int = 10



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	afficheScore()


func _on_table_normale_shop() -> void:
	$Shop.visible = true
	$TableNormale.visible = false
	$TableTopdown.visible = false


func _on_table_normale_play() -> void:
	$Shop.visible = false
	$TableNormale.visible = false
	$TableTopdown.visible = true

func _on_shop_exit_shop() -> void:
	$Shop.visible = false
	$TableNormale.visible = true
	$TableTopdown.visible = false
	
	
func afficheScore() -> void:
	$PlayerScore.text = "socre:" + str(PlayerVars.score) + "/" + str(scoreThreshold) + "\n" + "money:"+str(PlayerVars.money)
