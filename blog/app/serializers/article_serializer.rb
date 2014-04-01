class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :name, :content, :url
  has_many :comments
  embed :ids, include: true
  delegate :current_user, to: :scope

  serialization_scope

  def url
    article_url(object)
  end

  def attributes
    date = super
    data[:edit_url] = edit_article_url(object) if current_user.admin?
    data
  end
end
