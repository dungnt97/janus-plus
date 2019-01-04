class WarnConsoleLog
  def filter(text)
    %w(log debug info warn).any? { |pattern| text.include?("console.#{pattern}") }
  end
end
