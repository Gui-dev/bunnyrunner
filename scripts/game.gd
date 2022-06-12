extends Node2D


enum {MENU, LOADING, LOADED}
var status = MENU
var current_stage
var loaded_stage


func _ready() -> void:
  add_to_group('game')

func stage_selected(button: Button) -> void:
  if status == MENU:
    status = LOADING
    current_stage = button.stage
    $interface.hide()
    load_stage()
    status = LOADED

func load_stage():
  if loaded_stage != null:
    loaded_stage.queue_free()
  loaded_stage = load(current_stage).instance()
  add_child(loaded_stage)
