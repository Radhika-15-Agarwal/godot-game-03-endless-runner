extends CanvasLayer

@onready var score_label = get_tree().get_first_node_in_group("score_label")
@onready var high_score_label = get_tree().get_first_node_in_group("high_score_label")
@onready var game_over_label = get_tree().get_first_node_in_group("game_over_label")

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	GameManager.score_changed.connect(_on_score_changed)
	GameManager.game_over_changed.connect(_on_game_over_changed)
	
	# Initialize UI immediately
	_on_score_changed(GameManager.score)
	_on_high_score_changed(GameManager.high_score)
	_on_game_over_changed(GameManager.is_game_over)


func _process(delta):
	if high_score_label:
		high_score_label.text = "High Score: %d" % GameManager.high_score

func _on_score_changed(new_score):
	if score_label:
		score_label.text = "Score: %d" % new_score

func _on_high_score_changed(new_high_score):
	if high_score_label:
		high_score_label.text = "High Score: %d" % new_high_score

func _on_game_over_changed(state):
	if game_over_label:
		game_over_label.visible = state
