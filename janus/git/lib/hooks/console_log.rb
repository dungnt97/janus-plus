module Git
  class ConsoleLog
    def filter(lines)
      %w(log debug info warn).each do |pattern|
        lines.each do |line|
          if line.include?("console.#{pattern}")
            return [false, "[console.#{pattern}] found in [#{line}]"]
          end
        end
      end

      [true, nil]
    end

    def disable_env_key
      "ALLOW_CONSOLE_LOG"
    end
  end
end
