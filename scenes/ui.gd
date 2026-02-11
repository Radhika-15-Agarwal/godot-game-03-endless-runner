extends CanvasLayer

@onready var score_label = get_tree().get_first_node_in_group("score_label")
@onready var high_score_label = get_tree().get_first_node_in_group("high_score_label")
@onready var game_over_label = get_tree().get_first_node_in_group("game_over_label")

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func _process(delta):
	if score_label:
		score_label.text = "Score: %d" % GameManager.score
		
	if high_score_label:
		high_score_label.text = "High Score: %d" % GameManager.high_score
		
	if game_over_label:
		game_over_label.visible = GameManager.is_game_over
