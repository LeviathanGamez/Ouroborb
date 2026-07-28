extends RichTextLabel

var victory = "[rainbow][wave]You Win! [/wave][/rainbow]You've mastered Ouroborb. Keep playing to chase higher scores."

func _ready():
	GlobalGameManager.winner.connect(toggle_text)


func toggle_text(value):
	if value > 0:
		text = victory
