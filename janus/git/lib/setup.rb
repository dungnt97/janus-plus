require "fileutils"

module Git
  class Setup
    def perform
      replace_symlink(
        File.expand_path("~/.gitconfig"),
        File.expand_path("../../gitconfig", __FILE__),
        File.expand_path("~/.gitconfig.local")
      )

      replace_symlink(
        File.expand_path("~/.git-tools"),
        File.expand_path("../..", __FILE__)
      )
    end

    def replace_symlink(location, new_target, move_current_nonsymlink_to = nil)
      if File.symlink?(location)
        FileUtils.rm_rf location
      elsif File.exist?(location)
        if move_current_nonsymlink_to
          FileUtils.mv(location, move_current_nonsymlink_to)
        else
          print "Overwrite #{location}? [yN]"
          if (STDIN.gets.chomp == "y")
            puts "Overwriting"
            FileUtils.rm_rf location
          else
            puts "Skipping"
          end
        end
      end

      FileUtils.ln_s(new_target, location)
    end
  end
end
