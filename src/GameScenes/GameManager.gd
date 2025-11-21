extends Node

var wave




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_table_normale_shop() -> void:
	$Shop.visible = true
	$TableNormale.visible = false
	$TableTopdown.visible = false


func _on_table_normale_play() -> void:
	$Shop.visible = false
	$TableNormale.visible = false
	$TableTopdown.visible = true
