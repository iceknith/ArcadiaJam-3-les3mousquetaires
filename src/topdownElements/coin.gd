class_name Coin extends Sprite2D

signal animEnd

@export_group("Stats")
@export var chance:float = 0.5
@export var price:int = 1
@export var effectPos = ""
@export var valuePos:float = 1
@export var effectNeg = ""
@export var valueNeg:float = 1

@export var coinName:String

@export_group("Mouvements")
@export var mouvementMedian:Vector2 = Vector2(0,-500)
@export var variance:Vector2 = Vector2(100,100)

@export_group("Visuals")
@export var goodSideColor:Color
@export var badSideColor:Color

@export_group("AnimationVars")
@export var dist_to_posFinale_perc:float = 1
@export var color_perc:float = 0
@export var decided_color:bool = false
@export var modulateAlpha:float

var positionFinale:Vector2
var positionInit:Vector2

var resultat:bool
var finalValue:float

func _ready() -> void:
	resultat = randf() <= chance*PlayerVars.luck 
	positionInit = position
	positionFinale = positionInit + mouvementMedian + Vector2(randf()*variance.x, randf()*variance.y)
	var visibleRect = get_window().get_visible_rect()
	positionFinale = clamp(positionFinale, 
		visibleRect.position, 
		visibleRect.position + visibleRect.size)
	
	if resultat:
		if effectPos in OrganVars.organs.keys():
			finalValue = valuePos * PlayerVars.organes.get(effectPos)
		else:
			finalValue = valuePos
		finalValue = finalValue * PlayerVars.coin_multiplicateur + PlayerVars.coin_additionneur
	else:
		if effectNeg in OrganVars.organs.keys():
			finalValue = valueNeg * PlayerVars.organes.get(effectNeg)
		else:
			finalValue = valueNeg
	
	
	if resultat: 
		$Label.label_settings.font_color = goodSideColor
	else: 
		$Label.label_settings.font_color = badSideColor
	
	if finalValue > 0: $Label.text = "+" + str(finalValue)
	elif finalValue < 0: $Label.text = str(finalValue)
	else: $Label.text = "Oops"
	
	print(finalValue)
	
	add_to_group("coins")
	
func _process(delta: float) -> void:
	position = positionInit + (positionFinale - positionInit) * dist_to_posFinale_perc
	if resultat && decided_color: 
		modulate = badSideColor + (goodSideColor - badSideColor) * color_perc
	else: 
		modulate = goodSideColor + (badSideColor - goodSideColor) * color_perc
	modulate.a = modulateAlpha
	$PointLight2D.color = modulate

func animEnded() -> void:
	animEnd.emit()
	# C'est ici qu'on change l'argent qui est ajoutée au joueur
	get_tree().get_nodes_in_group("UI")[0].add_money(finalValue)

func coinLand() -> void:
	if resultat: $CoinLandYes.play()
	else: $CoinLandNo.play()
