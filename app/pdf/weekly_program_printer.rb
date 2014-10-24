class WeeklyProgramPrinter
  include Prawn::View
  include Printer

  def initialize(weekly_program)
    @weekly_program = weekly_program
    if @weekly_program.instance_of? WeeklyProgram
      write_header
      write_title('Weekly Program from ' + @weekly_program.week_range)
      write_indoor_programs
      start_new_page
      write_outdoor_programs
      move_down 20
      write_group_time_plannings
    end
  end

  # def document
  #   @document ||= Prawn::Document.new(page_layout: :landscape)
  # end

  private

  def write_indoor_programs
    write_category('Indoor Program')
    write_weekly_program_property_group1
    write_activities(@weekly_program.indoor_activities)
  end

  def write_outdoor_programs
    write_category('Outdoor Program')
    write_weekly_program_property_group1
    write_activities(@weekly_program.outdoor_activities)
  end

  def write_group_time_plannings
    write_category('Group Time Planning')
    write_weekly_program_property_group2
    write_group_activities(@weekly_program.group_time_plannings_sorted)
  end

  def write_category(category)
    text "#{h3(category)}", inline_format: true
    move_down 10
  end

  def write_weekly_program_property_group1
    font('Courier', size: 11) do
      text "Program Staff: #{@weekly_program.program_staff}  Theme: #{@weekly_program.theme}  Goal: #{@weekly_program.goals}"
    end
    move_down 10
  end

  def write_weekly_program_property_group2
    font('Courier', size: 11) do
      text "Letter: #{@weekly_program.letter}  Number: #{@weekly_program.number}  Colour: #{@weekly_program.colour}  Shape: #{@weekly_program.shape}"
    end
    move_down 10
  end

  def write_activities(activities)
    activities.each do |activity|
      move_down 5
      text "#{h4(activity.day)}", inline_format: true
      move_down 5
      data = [[th('Cognitive'), th('Cross Mentor'), th('Social/Emotional'), th('Fine motor Eye-hand co. Sensory Art and craft'), th('Language')]]
      data << [activity.cognitive, activity.cross_mentor, activity.social, activity.art_and_craft, activity.language]
      data << [activity.cognitive_outcome, activity.cross_mentor_outcome, activity.social_outcome, activity.art_and_craft_outcome, activity.language_outcome]
      table(data, position: :center, row_colors: %w(008CBA FFFFFF a0d3e8),
            cell_style: {:inline_format => true,
                         size: 8},
            column_widths: [105, 105, 105, 105, 105]
      )
      move_down 20
    end
  end

  def write_group_activities(activities)
    activities.each do |activity|
      move_down 5
      text "#{h4(activity.day)}", inline_format: true
      move_down 5
      data = [[th('Transition song 9:00 AM'), th('Show and tell 11:00 AM'), th('Computer 2:45 PM'), th('Story time 3:30 PM'), th('Game group time 5:15 PM')]]
      data << [activity.morning, activity.late_morning, activity.afternoon, activity.late_afternoon, activity.finishing_up]
      table(data, position: :center, row_colors: %w(008CBA FFFFFF),
            cell_style: {:inline_format => true,
                         size: 8},
            column_widths: [105, 105, 105, 105, 105]
      )
      move_down 20
    end
  end
end
