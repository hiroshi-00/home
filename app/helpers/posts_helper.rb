module PostsHelper
  def html_helper(content)
    return content.html_safe if content
  end
  
  def truncate_content(content)
    content = strip_tags(content).truncate(150)
  end
end
