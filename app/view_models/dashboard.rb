class Dashboard
  delegate :role, to: :user
  delegate :posts, to: :user

  attr_reader :user

  def initialize(user)
    @user = user
  end

  def recent_posts
    Post.all.order(updated_at: :desc)
  end
end
