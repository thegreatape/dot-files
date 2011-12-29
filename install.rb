#!/usr/bin/env ruby
require 'fileutils'

# Get all the file, with the ones we don't want to link filtered out
files = Dir['*'].reject {|f| f =~ /^(.*\.kmmacros|install\.rb|todo\.cfg|README)/i}

# Create an absolute path from our working directory
files = files.map { |file| File.join( File.dirname(File.expand_path(__FILE__)), file ) } 

home = File.expand_path('~/')
puts "Linking in #{home}/"
files.each do |from|
  next unless (File.file?(from) || File.directory?(from))

  to = File.join(home, '.' + File.basename(from))

  puts " - " + [from, to].join(' -> ')
  if File.symlink? to
    FileUtils.rm to
    puts " ! Target exists... as a symlink, removed"
  elsif File.exists?(to)
    puts " ! Target exists... as a normal file/directory, moving to #{File.basename(to)}~... "
    toto = to + '~'

    if File.exist? toto
      print "already exists! r)emove, or s)kip? "
      order = STDIN.gets.chomp

      case order
      when 'r'
        puts ' ! Removing... '
        FileUtils.rm toto
      when 's'
        puts ' ! Okay, skipped '
        next
      else
        puts " ! Invalid entry, so skipping"
        next
      end
    end

    FileUtils.mv to, toto
    puts "Done!"
  end 

  FileUtils.symlink(from, to)
end
`git submodule update --init`

