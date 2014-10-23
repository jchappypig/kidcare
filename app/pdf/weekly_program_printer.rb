class WeeklyProgramPrinter
  include Prawn::View

  def initialize(weekly_program)
    @weekly_program = weekly_program
    write_title
    write_header
    write_indoor_programs
    start_new_page
    write_outdoor_programs
  end

  private
  def write_title
    text "#{h4('Little Start Early Learning Centre')}", inline_format: true
    stroke_horizontal_rule
    move_down 20
  end

  def write_header
    text "#{h1('Weekly Program from ' + @weekly_program.week_range)}", inline_format: true
    move_down 20
  end

  def write_indoor_programs
    text "#{h3('Indoor Program')}", inline_format: true
    write_activities(@weekly_program.indoor_activities)
  end

  def write_outdoor_programs
    text "#{h3('Outdoor Program')}", inline_format: true
    write_activities(@weekly_program.outdoor_activities)
  end

  def write_activities(activities)
    activities.each do |activity|
      move_down 5
      text "#{h4(activity.day)}", inline_format: true
      move_down 5
      data = [[th('Cognitive'), th('Cross Mentor'), th('Social/Emotional'), th('Fine motor Eye-hand co. Sensory Art and craft'), th('Language')]]
      data << [activity.cognitive, activity.cross_mentor, activity.social, activity.art_and_craft, activity.language]
      data << [activity.cognitive_outcome, activity.cross_mentor_outcome, activity.social_outcome, activity.art_and_craft_outcome, activity.language_outcome]
      table(data, position: :center, row_colors: ['008CBA', 'FFFFFF', 'a0d3e8'],
            cell_style: {:inline_format => true,
                         size: 8},
            column_widths: [105, 105, 105, 105, 105]
      )
      move_down 20
    end
  end

  def th(text)
    "<b><color rgb='FFFFFF'>#{text}</color></b>"
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
