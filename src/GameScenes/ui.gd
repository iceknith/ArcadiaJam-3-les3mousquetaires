extends Node

var moneyBuffer:float
var displayedMoney:float

var bufferTimeBeforeAdding:float = 0.3

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("UI")
	refresh()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func refresh():
	$money.text = str(displayedMoney) + " / " + str(PlayerVars.debt)
	if moneyBuffer > 0: 
		$AddMoney.text = "+"
		$AddMoney.show()
	elif moneyBuffer < 0:
		$AddMoney.text = ""
		$AddMoney.show()
	else: 
		$AddMoney.hide()
	$AddMoney.text += str(moneyBuffer)
	
	if PlayerVars.round_left > 1:
		$round_left.text = str(PlayerVars.round_left) + " rounds left"
	elif PlayerVars.round_left == 1:
		$round_left.text = "Last round"
	else:
		$round_left.text = str(PlayerVars.round_left) + " rounds left"

func add_money(value:float):
	PlayerVars.money += value
	moneyBuffer += value
	$money/AddMoneyAnim.play("addBufferMoney")
	refresh()

func _on_round_ended() -> void:
	$money/MoneyTransvaseTimer.start()

func _on_money_transvase_timer_timeout() -> void:
	if moneyBuffer != 0:
		var addedQuantity:float = min(sign(moneyBuffer), moneyBuffer)
		displayedMoney += addedQuantity
		moneyBuffer -= addedQuantity
		$money/AddMoneyAnim.play("transvase")
		refresh()
	else: $money/MoneyTransvaseTimer.stop()
