extends Button

export(String, FILE) var stage
export(String, FILE) var music
export(String) var stage_name = 'stage-00'

func _ready() -> void:
  pass


func _on_stage_button_pressed() -> void:
 get_tree().call_group('game', 'stage_selected', self)
