extends KinematicBody2D

const GRAVITY = 1500
var speed_direction_x = 500
var velocity = Vector2(0, 0)
var jump = false
var jump_release = false
var controled_jump = false
var was_on_floor = false

onready var mask = collision_mask
onready var layer = collision_layer

enum {IDLE, RUNNING, FLYING, DEAD, VICTORY}
var status = IDLE
var display_size = ProjectSettings.get_setting('display/window/size/height')

func _ready() -> void:
  add_to_group('player')
  $sprite.play('idle')
  set_process_input(true)

func _physics_process(delta: float) -> void:
  if status == RUNNING:
    running(delta)
  elif status == FLYING:
    flying(delta)
  elif status == DEAD:
    dead(delta)
  
  if status != DEAD:
    if position.y > display_size:
      killed()
  
  jump = false
  jump_release = false

func start():
  status = RUNNING

func running(delta: float) -> void:
  velocity.y += GRAVITY * delta
  velocity.x = speed_direction_x
  velocity = move_and_slide(velocity, Vector2(0, -1))
  
  if is_on_floor():
    if not was_on_floor:
      $animation_landed.play('boing')
      $dust/animation_dust.play('dust')
    $sprite.play('walk')
    if jump:
      _jump(1000, true)
      $jump.play()
  else:
    $sprite.play('jump')
    if jump_release and velocity.y < 0 and controled_jump:
      velocity.y *= 0.3
  
  was_on_floor = is_on_floor()

func _input(event):
  if event is InputEventScreenTouch or event.is_action('jump'):
    if event.pressed:
      jump = true
    else:
      jump_release = true

func _jump(force: int, controled: bool) -> void:
  velocity.y = -force
  controled_jump = controled

func killed() -> void:
  if status != DEAD:
    status = DEAD
    mask = 0
    layer = 0
    velocity = Vector2(0, -1000)
    $dead.play()
    get_tree().call_group('power_up_bar', 'stop')
    get_tree().call_group('game', 'player_dying')

func dead(delta: float) -> void:
  $sprite.play('hurt')
  translate((velocity * delta))
  velocity.y += GRAVITY * delta
  
  if global_position.y > display_size + 200:
    get_tree().call_group('game', 'player_died')

func fly() -> void:
  $sprite.play('jump')
  _jump(400, false)
  status = FLYING
  $wings.visible = true
  
func flying(delta: float) -> void:
  velocity.y += GRAVITY * delta
  velocity.x = speed_direction_x
  velocity = move_and_slide(velocity, Vector2(0, -1))
  
  if jump:
    $wings/animation.play('flap')
    _jump(400, false)
    $flap.play()
    
  if is_on_floor():
    get_tree().call_group('power_up_bar', 'stop')
    power_up_finished()

func victory() -> void:
  $sprite.play('victory')
  status = VICTORY
  get_tree().call_group('game', 'player_victory')
  
func power_up_finished() -> void:
  if status != DEAD:
    status = RUNNING
    $wings.visible = false
    
