module Printer
  def write_header
    text "#{h4('Little Start Early Learning Centre')}", inline_format: true
    stroke_horizontal_rule
    move_down 20
  end

  def write_title(title)
    text "#{h1(title)}", inline_format: true
    move_down 20
  end

  def th(text)
    "<b><color rgb='FFFFFF'>#{text}</color></b>"
  end

  def row_th(text)
    "<b>#{text}</b>"
  end

  def h4(text)
    "<b><i><color rgb='008CBA'>#{text}</color></i></b>"
  end

  def h1(text)
    "<b><font size='20'>#{text}</font></b>"
  end

  def h3(text)
    "<b><font size='16'>#{text}</font></b>"
  end
end
