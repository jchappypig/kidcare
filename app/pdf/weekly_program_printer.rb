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
      start_new_page
      write_group_time_plannings
    end
  end

  def document
    @document ||= Prawn::Document.new(page_layout: :landscape)
  end

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
    data = []
    days = [th('Broad Skill')]
    column_widths = [80]
    available_days = activities.map(&:day)
    column_width = 640.0.to_f/available_days.size

    available_days.each do |day|
      days << th(day)
      column_widths << column_width
    end

    data << days

    cognitive_data = [row_th('Cognitive')]
    cross_mentor_data = [row_th('Cross Mentor')]
    social_data = [row_th('Social/Emotional')]
    art_and_craft_data = [row_th('Fine motor Eye-hand co. Sensory Art and craft')]
    language_data = [row_th('Language')]

    activities.each do |activity|
      cognitive_data << activity.cognitive
      cross_mentor_data << activity.cross_mentor
      social_data << activity.social
      art_and_craft_data << activity.art_and_craft
      language_data << activity.language
    end

    data << cognitive_data
    data << cross_mentor_data
    data << social_data
    data << art_and_craft_data
    data << language_data


    table(data, position: :center, row_colors: %w(008CBA FFFFFF a0d3e8 FFFFFF a0d3e8 FFFFFF),
          cell_style: {:inline_format => true,
                       size: 8},
          column_widths: column_widths
    )

    move_down 20
  end

  def write_group_activities(activities)
    data = []
    days = [th('Group Time')]
    column_widths = [80]
    available_days = activities.map(&:day)
    column_width = 640.0.to_f/available_days.size

    available_days.each do |day|
      days << th(day)
      column_widths << column_width
    end

    morning_data = [row_th('Transition song 9:00 AM')]
    late_morning_data = [row_th('Show and tell 11:00 AM')]
    afternoon_data = [row_th('Computer 2:45 PM')]
    late_afternoon_data = [row_th('Story time 3:30 PM')]
    finishing_up_data = [row_th('Game group time 5:15 PM')]

    data << days

    activities.each do |activity|
      morning_data << activity.morning
      late_morning_data << activity.late_morning
      afternoon_data << activity.afternoon
      late_afternoon_data << activity.late_afternoon
      finishing_up_data << activity.finishing_up
    end

    data << morning_data
    data << late_morning_data
    data << afternoon_data
    data << late_afternoon_data
    data << finishing_up_data


    table(data, position: :center, row_colors: %w(008CBA FFFFFF a0d3e8 FFFFFF a0d3e8 FFFFFF),
          cell_style: {:inline_format => true,
                       size: 8},
          column_widths: column_widths
    )

    move_down 20
  end
end
