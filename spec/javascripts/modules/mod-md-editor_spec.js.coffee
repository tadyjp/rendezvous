#= require modules/mod-md-editor

describe "mod-md-editor", ->

  text = new _mod_md_editor.TextareaText("aaaaaaaa\nbbbbbb\n\ncccccc", 10, 18)

  it "_mod_md_editor.parse", ->
    expect(text.total_line_num()).toBe(4)
    expect(text.current_line_num()).toBe()
    expect(text.current_line_head_pos()).toBe(4)
    expect(text.current_pos_in_line()).toBe(4)
