#! /usr/bin/ruby

def hosts_file_name
  "/etc/hosts"
end

def start_focus
  File.open(hosts_file_name, "a") do |f|
    ["news.ycombinator.com", "facebook.com", "m.facebook.com", "messenger.com", "youtube.com"].each do |domain|
      f.puts("::1  #{domain}  #FOCUS")
      f.puts("::1  www.#{domain}  #FOCUS")
      f.puts("127.0.0.1  #{domain}  #FOCUS")
      f.puts("127.0.0.1  www.#{domain}  #FOCUS")
    end
  end
  puts 'Started'
end

def end_focus
  lines_to_keep = []

  File.open(hosts_file_name, "r") do |f|
    f.each_line do |l|
      lines_to_keep << l unless l =~ /#FOCUS/
    end
  end

  File.open(hosts_file_name, "w") do |f|
    lines_to_keep.each do |l|
      f << l
    end
  end
end

start_focus

minute_counter = 50
while(true) do
  if minute_counter <= 0
    puts "Done!                                "
    break
  else
    print "Time left: #{minute_counter} minutes"
    print 13.chr
  end

  sleep 60
  minute_counter -= 1
end

end_focus
