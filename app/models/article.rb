class Article < ApplicationRecord
    include Visible

    scope :featured, -> { where(featured: true).first }

    has_many :comments, dependent: :destroy
    has_many :taggings, dependent: :destroy
    has_many :tags, through: :taggings
    has_one_attached :image

    validates :title, presence: true
    validates :body, presence: true, length: { minimum: 10 }

    def only_one_featured_article
        if featured && Article.where(featured: true).where.not(id: id).exist?
            errors.add(:featured, 'can only be one featured at a time')
        end
    end

    # Redundant logic with comment. So it's being simplified in concern
    # from concern we do "include Visible" above
    # VALID_STATUSES = [ 'public', 'private', 'archived' ]

    # validates :status, inclusion: { in: VALID_STATUSES }

    # def archived?
    #     status == 'archived'
    # end
end
