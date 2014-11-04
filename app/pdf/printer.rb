module Printer
  def write_header
    font 'Gloria Hallelujah'
    text "#{h4('Little Start Early Learning Centre')}", inline_format: true
    stroke_horizontal_rule
    move_down 20
    font 'Lato'
  end

  def write_title(title)
    font 'Nunito'
    text "#{h1(title)}", inline_format: true
    move_down 20
    font 'Lato'
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

  def initialize_fonts
    font_families.update('Lato' => {
        :normal => "#{Rails.root}/app/assets/stylesheets/Lato-Regular.ttf",
        :italic => "#{Rails.root}/app/assets/stylesheets/Lato-Italic.ttf",
        :bold => "#{Rails.root}/app/assets/stylesheets/Lato-Bold.ttf",
        :bold_italic => "#{Rails.root}/app/assets/stylesheets/Lato-BoldItalic.ttf"
    })

    font_families.update('Gloria Hallelujah' => {
        :normal => "#{Rails.root}/app/assets/stylesheets/gloriahallelujah.ttf",
        :italic => "#{Rails.root}/app/assets/stylesheets/gloriahallelujah.ttf",
        :bold => "#{Rails.root}/app/assets/stylesheets/gloriahallelujah.ttf",
        :bold_italic => "#{Rails.root}/app/assets/stylesheets/gloriahallelujah.ttf"
    })

    font_families.update('Nunito' => {
        :normal => "#{Rails.root}/app/assets/stylesheets/Nunito-Regular.ttf",
        :italic => "#{Rails.root}/app/assets/stylesheets/Nunito-Regular.ttf",
        :bold => "#{Rails.root}/app/assets/stylesheets/Nunito-Bold.ttf",
        :bold_italic => "#{Rails.root}/app/assets/stylesheets/Nunito-Bold.ttf"
    })

    font 'Lato'
  end
end
