module Git
  class Debugger
    def filter(lines)
      %w(byebug debugger).each do |pattern|
        lines.each do |line|
          if line.include?(pattern)
            return [false, "[#{pattern}] found in [#{line}]"]
          end
        end
      end

      [true, nil]
    end

    def disable_env_key
      "ALLOW_DEBUGGER"
    end
  end
end
