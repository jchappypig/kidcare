class WeeklyProgramPrinter
  include Prawn::View

  def initialize(weekly_program)
    @weekly_program = weekly_program
  end

  def write_to_pdf
    text "Hello, #{@weekly_program.week_start}"
  end
end
