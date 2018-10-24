#!/usr/bin/env ruby

require "fileutils"

class Bootstrap
  def die(message)
    echo message
    exit 1
  end

  def home
    ENV['HOME']
  end

  def forced?
    ENV["FORCED"]
  end

  def backup_previous_install
    # Add .old to any existing Vim file in the home directory
    %w(.vim .vimrc .gvimrc .tmux.conf).each do |name|
      path = [home, name].join("/")
      if File.exist?(home)
        FileUtils.mv(path, "#{path}.old") || die("Could not move #{path} to #{path}.old")
      end
    end
  end

  def clone_janus
    system("git clone --recursive https://github.com/remitano/janus-tmux.git #{home}/.vim") || die("Could not clone the repository to #{home}/.vim")
  end

  def run_rake
    Dir.chdir("/tmp") do
      system("rake") || die("Rake failed.")
    end
  end

  def main()
    if !File.exist?("#{home}/.vim/janus") || forced? then
      backup_previous_install
      clone_janus
    end
    run_rake
  end
end

Bootstrap.new.main
