class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  has_many :comments, :as => :commentable
  validates_presence_of :title,:body
  def article
    commentable.is_a?(Article) ? commentable : commentable.article
  end
end
