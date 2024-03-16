extends Button

var is_shown : bool = true

func _on_pressed():
    is_shown = not is_shown
    #self.modulate = Color(1,1,1,is_hidden)
    self.add_theme_color_override("font_color", Color(1,1,1,is_shown))
    self.add_theme_color_override("font_focus_color",Color(1,1,1,is_shown))
    self.add_theme_color_override("font_hover_color",Color(1,1,1,is_shown))
