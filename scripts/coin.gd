extends Area2D

func _ready() -> void:
  get_tree().call_group('game', 'add_stage_coins')


func _on_coin_body_entered(_body: Node) -> void:
  $action.play()
  $sprite.visible = false
  collision_mask = 0
  $queue_timer.start()
  $particles.emitting = true
  get_tree().call_group('coin_counter', 'pick_coin')

func _on_queue_timer_timeout() -> void:
  queue_free()
