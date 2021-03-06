extends Area2D


export var time = 10.0 

func _ready() -> void:
  $sprite.visible = true


func _on_fly_powerup_body_entered(body: Node) -> void:
  get_tree().call_group('power_up_bar', 'start', time)
  body.fly()
  $sprite.visible = false
