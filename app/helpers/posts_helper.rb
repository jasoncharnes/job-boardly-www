module PostsHelper
  def posts
    @posts ||= Spina::Resource.find_by(name: "posts").pages.live.order(created_at: :desc)
  end

  def post_published_at(post = current_page)
    Date.parse(post.content(:published_at)).strftime("%B %d, %Y")
  end

  def related_posts
    @related_posts ||= Spina::Resource.find_by(name: "posts").pages
      .live.where.not(id: current_page.id)
      .reorder("RANDOM()").limit(2)
  end
end
