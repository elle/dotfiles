require "rake"

desc "install dotfiles into user's home dir"
task :install do
  Dir['*'].each do |file|
    next if %w[Rakefile readme.md].include? file

    if File.exist?(File.join(ENV['HOME'], ".#{file}"))
      puts "backing up '.#{file}' -> '#{file}_bkp'"
      system %Q{mv "$HOME/.#{file}" "$HOME/.#{file}_bkp"}
    end

    puts "linking ~/.#{file}"
    system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
  end

  if `which nvim > /dev/null`
    # Use existing Vim confirguation with NeoVim
    system "ln -s ~/.vim ~/.config/nvim"
    system "ln -s ~/.vimrc ~/.config/nvim/init.vim"
  end
end
