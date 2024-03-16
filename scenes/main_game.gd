extends MarginContainer

@onready var left_new_word = $VBoxContainer/InputContainer/LeftNewWordTextEdit
@onready var right_new_word = $VBoxContainer/InputContainer/RightNewWordTextEdit
@onready var word_pairs_container = $VBoxContainer/ScrollContainer/WordPairsContainer

const SAVEFILE : String = "user://langcard.save"
var word_pairs : Array[String] = ['word_word']

func _ready():
    load_game()

func load_game():
    if not FileAccess.file_exists(SAVEFILE):
        return
    var save_game = FileAccess.open(SAVEFILE, FileAccess.READ)

    var json_string = save_game.get_line()

    var json = JSON.new()

    var parse_result = json.parse(json_string)
    if not parse_result == OK:
        push_error("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
        return

    var word_pairs = json.get_data()

    for word_pair_str : String in word_pairs:
        var word_pair : PackedStringArray = word_pair_str.split('_', false)
        if len(word_pair) == 2:
            add_word_pair(word_pair[0], word_pair[1])


func add_word_pair(left_word : String, right_word : String):
    var word_pair : WordPair = load("res://ui/word_pair.tscn").instantiate()
    word_pair.left_word = left_word
    word_pair.right_word = right_word
    word_pair.delete_wordpair.connect(_on_word_pair_delete_wordpair)
    word_pairs_container.add_child(word_pair)
    word_pairs.append(left_word + '_' + right_word)

func save_game():
    var save_game = FileAccess.open(SAVEFILE, FileAccess.WRITE)

    var json_string = JSON.stringify(word_pairs)

    save_game.store_line(json_string)


func _on_button_pressed():
    var left_word : String = left_new_word.text
    var right_word : String = right_new_word.text

    add_word_pair(left_word, right_word)

    save_game()

    left_new_word.clear()
    right_new_word.clear()


func _on_word_pair_delete_wordpair(left_word : String, right_word : String):
    var word_pair_idx : int = word_pairs.find(left_word + '_' + right_word)
    if word_pair_idx >= 0:
        word_pairs.remove_at(word_pair_idx)
        save_game()
    else:
        prints(left_word,"_",right_word,"not found")

