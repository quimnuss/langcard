extends HBoxContainer
class_name WordPair

@onready var left_sprache_wort = $LeftSpracheWort
@onready var right_sprache_wort = $RightSpracheWort

signal delete_wordpair(left_word : String, right_word : String)

var left_word : String:
    set(new_left_word):
        if not is_node_ready():
            await ready
        left_sprache_wort.text = new_left_word
    get:
        return left_sprache_wort.text

var right_word : String:
    set(new_right_word):
        if not is_node_ready():
            await ready
        right_sprache_wort.text = new_right_word
    get:
        return right_sprache_wort.text

func _on_button_pressed():
    delete_wordpair.emit(left_word, right_word)
    queue_free()
