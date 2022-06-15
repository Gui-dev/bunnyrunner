extends Node2D


enum {MENU, LOADING, LOADED}
var status = MENU
var current_stage
var current_music
var loaded_stage
var reference_stage

func _ready() -> void:
  $HUD/countdown.visible = false
  $HUD/stage_exit.visible = false
  add_to_group('game')

func stage_selected(button: Button) -> void:
  if status == MENU:
    status = LOADING
    current_stage = button.stage
    current_music = button.music
    $interface.visible = false
    load_stage()
    $HUD/controls.visible = true
    status = LOADED

func load_stage():
  if loaded_stage != null && reference_stage.get_ref() != null:
    loaded_stage.queue_free()
  loaded_stage = load(current_stage).instance()
  reference_stage = weakref(loaded_stage)
  
  if current_music:
    $music.stream = load(current_music)
    
  add_child(loaded_stage)
  $HUD/stage_exit.visible = true
  $HUD/countdown/animation.play('countdown')
  yield($HUD/countdown/animation, 'animation_finished')
  get_tree().call_group('player', 'start')
  play_music()

func player_died():
  load_stage()

func stage_exit():
  loaded_stage.queue_free()
  $interface.visible = true
  $HUD/controls.visible = false
  $HUD/stage_exit.visible = false
  $HUD/countdown.visible = false
  status = MENU
  stop_music()

func player_victory():
  stop_music()
  $audio_victory.play()
  var timer = get_tree().create_timer(4)
  yield(timer, 'timeout')
  stage_exit()

func player_dying() -> void:
  stop_music()

func play_music() -> void:
  if current_music:
    $music.play()
    
func stop_music() -> void:
  $music.stop()

func _on_stage_exit_pressed() -> void:
  stage_exit()
