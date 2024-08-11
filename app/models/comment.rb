class Comment < ApplicationRecord
  include Visible

  belongs_to :article

  # Redundant logic with article. So it's being simplified in concern
  # from concern we do "include Visible" above
  # VALID_STATUSES = [ 'public', 'private', 'archived' ]

  # validates :status, inclusion: { in: VALID_STATUSES }

  # def archived?
  #     status == 'archived'
  # end
end
