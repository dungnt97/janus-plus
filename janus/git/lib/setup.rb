require "fileutils"

module Git
  class Setup
    def perform
      if current_gitconfig_symlinked?
        FileUtils.rm_rf current_gitconfig_path
      elsif current_gitconfig_existed?
        FileUtils.mv(current_gitconfig_path, local_gitconfig_path)
      end

      FileUtils.ln_s(shared_gitconfig_path, current_gitconfig_path)
    end

    def current_gitconfig_symlinked?
      File.symlink?(current_gitconfig_path)
    end

    def current_gitconfig_existed?
      File.exist?(current_gitconfig_path)
    end

    def current_gitconfig_path
      File.expand_path "~/.gitconfig"
    end

    def local_gitconfig_path
      File.expand_path "~/.gitconfig.local"
    end


    def shared_gitconfig_path
      File.expand_path("../../gitconfig", __FILE__)
    end
  end
end
