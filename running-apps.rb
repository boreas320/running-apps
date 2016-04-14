Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8
apps = `osascript -e 'tell application "System Events" to get the file of every process whose background only is false'`
apps = apps.strip.split(",").collect {|line| line.strip.gsub(/^alias Macintosh HD/, '').gsub(/:/, '/')[0..-2]}.sort

puts "<items>"
apps.each do |line|
  app_path = line
  app_name = File.basename(app_path, ".app")
  query = "{query}"
  if ! app_name.downcase[query]
    next
  end
  if !(app_path =~ /^\/System\//) && !(app_path =~ /^\/Library\//)
  puts <<ENDS_HERE
  <item uid="status" arg="#{app_name}">
	<title>#{app_name}</title>
	<subtitle>Press Enter to activate #{app_path}</subtitle>
	<icon type="fileicon">#{app_path}</icon>
  </item>
ENDS_HERE
  end
end
puts "</items>"
