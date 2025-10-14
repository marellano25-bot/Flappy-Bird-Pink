extends CanvasLayer

func _ready() -> void:
	Global.connect("on_Increment_score", change_score)

func _process(delta: float) -> void:
	#$LabelScore.text = str(Global.score)
	pass
func change_score():
	$LabelScore.text = str(Global.score)
