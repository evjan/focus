def hosts_file_name
  "/etc/hosts"
end

def start_focus
  File.open(hosts_file_name, "a") do |f|
    f.puts("#FOCUS BLOCKS")
    ["ycombinator.com", "facebook.com", "twitter.com", "reddit.com", "youtube.com"].each do |domain|
      f.puts("::1  #{domain}  #FOCUS")
      f.puts("::1  www.#{domain}  #FOCUS")
      f.puts("127.0.0.1  #{domain}  #FOCUS")
      f.puts("127.0.0.1  www.#{domain}  #FOCUS")
    end
  end
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
start_time = Time.now
while(true) do
  sleep 60
  time_diff = (Time.now - start_time)/60
  if time_diff >= 25
    puts "Done!"
    break
  else
    puts "#{time_diff} minutes have passed"
  end
end
end_focus
