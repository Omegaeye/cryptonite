class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.pagination_helper(page = 1, per_page = 20)
    page = 1 if page.to_i < 1
    per_page = 20 if per_page.to_i < 1
    offset = ((page.to_i - 1) * per_page.to_i)
    self.offset(offset).limit(per_page.to_i)
  end
end
