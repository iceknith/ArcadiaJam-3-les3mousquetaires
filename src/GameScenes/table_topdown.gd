extends Node2D

signal roundFinised

@export var scoreTime = 6

#other vars
var gameDone = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$scoreTimeDelay.wait_time = scoreTime


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_tree().get_nodes_in_group("coins").size() >= PlayerVars.organes.get("arm") && !gameDone:
		$scoreTimeDelay.start()
		gameDone = true

func roundEnd() -> void:
	roundFinised.emit()
	gameDone = false
	

func _on_score_time_delay_timeout() -> void:
	roundEnd()
