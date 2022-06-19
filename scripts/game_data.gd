extends Node

var error

var prize_file = 'user://prize'
var prizes = {}

func save_prize(stage: String, prize: int) -> void:
  prizes[stage] = prize
  var file = File.new()
  var err = file.open(prize_file, File.WRITE)
  if err == OK:
    file.store_string(to_json(prizes))
    file.close()
    print('file_saved')
  
