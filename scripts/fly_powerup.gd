extends Area2D


func _ready() -> void:
  pass


func _on_fly_powerup_body_entered(body: Node) -> void:
  body.fly()
  print('FLY: ', body)
