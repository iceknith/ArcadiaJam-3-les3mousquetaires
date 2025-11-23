extends Node2D

signal roundFinised

@export var scoreTime = 2

#other vars
var gameDone = false
var coinsThrown:int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$scoreTimeDelay.wait_time = scoreTime
	await  get_tree().process_frame


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_coin_finish_throw() -> void:
	coinsThrown += 1
	if coinsThrown >= PlayerVars.organes.get("arm") && !gameDone:
		get_tree().get_first_node_in_group("UI")._on_round_ended()
		$scoreTimeDelay.start()
		gameDone = true

func roundEnd() -> void:
	roundFinised.emit()
	PlayerVars.organes["tooth"]=0
	gameDone = false
	

func _on_score_time_delay_timeout() -> void:
	roundEnd()
