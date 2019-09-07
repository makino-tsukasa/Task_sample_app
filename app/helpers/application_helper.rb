module ApplicationHelper
  
  require "uri"
 
  def content_url_to_link(content)
    URI.extract(content, ["http", "https"]).uniq.each do |url|
      sub_text = ""
      sub_text << "<a href=" << url << " target=\"_blank\">" << url << "</a>"
    
      content.gsub!(url, sub_text)
    end
    
    content
  end
  
  def full_title(page_name = "")
    base_title = "Sample"
    if page_name.empty?
      base_title
    else
      page_name + " | " + base_title
    end
  end
end