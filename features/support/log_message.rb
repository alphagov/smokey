class LogMessage
  attr_reader :level, :message, :file, :location, :timestamp

  class LogMessage::JsError < StandardError; end

  def initialize(log)
    @message = log.message.strip.gsub(/%c/, '')
    @level = log.level
    @file = nil
    @location = nil

    extract_file_and_location!
  end

  def to_s
    first_line = [
      "\u{1F4DC} ",
      log_level,
      file_and_location
    ].compact.join(' ')

    second_line = formatted_message

    [first_line, second_line].join("\n")
  end

  def error?
    level == 'SEVERE'
  end

  private

  LEADING_SPACES = ' ' * 5

  def formatted_message
    message
      .gsub('\n', "\n")
      .gsub('\u003C', "\u003C")
      .split("\n")
      .map { |line| "#{LEADING_SPACES}#{line}" }
      .join("\n")
  end

  def log_level
    " #{level.downcase} "
  end

  def file_and_location
    return unless file && location

    "#{file} #{location}"
  end

  def extract_file_and_location!
    match = message.match(/^(.+)\s+?(\d+:\d+)\s+?(.+)$/)

    return unless match

    _, @file, @location, message = match.to_a
    @message = message.gsub(/^"(.+?)"$/, '\1')
  end
end
