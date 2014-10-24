require 'open-uri'

class StoriesPrinter
  include Prawn::View
  include Printer

  def initialize(date)
    @stories = Story.where(time_line: date)
    if @stories.any?
      write_header
      y_position_holder = cursor
      write_title("#{@stories.first.time_line.strftime('%A, %d %b %Y')} @ Little Star")
      image "#{Rails.root}/app/assets/images/teddyBear.jpg", width: 40, at: [350, y_position_holder+10]
      move_up 10
      write_stories
    end
  end

  private

  def write_stories
    @stories.each_with_index do |story, index|
      write_attachments(story)
      write_content(story)
      write_outcomes(story)
      write_separator unless index == (@stories.size - 1)
    end
  end

  def write_outcomes(story)
    pad(20) do
      data = []
      story.outcomes.each do |outcome|
        data << [outcome.long_description]
      end
      table(data, position: :center, width: 540,
            cell_style: {:inline_format => true,
                         background_color: 'ecfaff',
                         border_colors: 'b6edff',
                         padding: 10
            }
      )
    end
  end

  def write_content(story)
    pad_top(10) { text story.content }
  end

  def write_attachments(story)
    story_attachments = StoryAttachment.where(guid: story.guid)
    attachment_height = 180
    padding_right = 15
    padding_bottom = 10
    bounding_box_height = (story_attachments.size.to_f/2).ceil*(attachment_height + padding_bottom)

    if cursor < bounding_box_height + padding_bottom
      start_new_page
    end

    bounding_box([0, cursor], width: 540, height: bounding_box_height) do
      odd = false
      x_position_holder = 0
      y_position_holder = cursor

      story_attachments.each do |attachment|
        x_position_holder = 0 if !odd

        image = image open(attachment.photo_url), height: attachment_height, at: [x_position_holder, y_position_holder]

        image_origin_width = image.width.to_f
        image_origin_height = image.height.to_f
        image_processed_width = image_origin_width/image_origin_height * attachment_height

        x_position_holder = x_position_holder + image_processed_width + padding_right
        y_position_holder = y_position_holder - attachment_height - padding_bottom if odd
        odd = !odd
      end

    end
  end

  def write_separator
    stroke_color '008CBA'
    stroke do
      pad(20) { horizontal_rule }
    end
  end

end
