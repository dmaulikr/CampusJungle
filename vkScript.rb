# coding: utf-8
require 'open-uri'
require 'nokogiri'
def getPageWithID(id) 

  doc = Nokogiri::HTML(open("http://www.vk.com/id#{id}"))
  doc.search('title').each do |link|
    return link.content
  end
  end

totalResult = ""

(1..200).to_a.each do |i|
 result = getPageWithID i
  if(result != "ВКонтакті") 
  result = "#{i})#{result}\n"
  totalResult += result 	
  puts result
end
end
file = File.open("/tmp/names.txt", "w")
  file.write(totalResult)
puts "Finish" 
