Dir[File.expand_path("../hooks/**/*.rb", __FILE__)].each { |f| require f }
module Git
  class Hooks
    def hook_classes
      [ConsoleLog]
    end

    def hooks
      @hooks ||= hook_classes.map(&:new)
    end

    def process_diff(text)
      hooks.each do |hook|
        ok, message = hook.filter(text)
        if !ok
          puts "#{message}"
          if hook.respond_to?(:disable_env_key)
            if ENV[hook.disable_env_key]
              next puts "Ignore error due to #{hook.disable_env_key} has been set"
            else
              puts "use #{hook.disable_env_key}=1 git commit to bypass this check"
            end
          end
          puts "Commit aborted due to founded issues in diff"
          exit 1
        end
      end
    end

    def process
      process_diff(additional_diff)
    end

    def diff
      @diff ||= `git diff --cached  -U0`
    end

    def diff_lines
      @diff_lines ||= diff.split("\n")
    end

    def additional_diff
      @additional_diff ||= diff_lines.select { |line| line.start_with?("+") }.join("\n")
    end
  end
end
