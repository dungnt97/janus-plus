module Git
  class ConsoleLog
    def filter(text)
      %w(log debug info warn).each do |pattern|
        if text.include?("console.#{pattern}")
          return [false, "console.#{pattern} found in diff"]
        end
      end

      [true, nil]
    end

    def disable_env_key
      "ALLOW_CONSOLE_LOG"
    end
  end
end
