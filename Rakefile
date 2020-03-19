require "rake"

desc "install dotfiles into user's home dir"
task :install do
  Dir['*'].each do |file|
    next if %w[Brewfile Rakefile readme.md setup adblock].include? file

    if File.exist?(File.join(ENV['HOME'], ".#{file}"))
      puts "backing up '.#{file}' -> '#{file}_bkp'"
      system %Q{mv "$HOME/.#{file}" "$HOME/.#{file}_bkp"}
    end

    puts "linking ~/.#{file}"
    system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
  end
end
