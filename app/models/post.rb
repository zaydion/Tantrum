class Post < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc)}
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 240 }

  def delete_if_old
    if (age > 2.hours)
      self.destroy
    end
  end

  def age
    (Time.now - self.created_at)
  end
end
