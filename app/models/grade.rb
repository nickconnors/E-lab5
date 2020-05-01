class Grade < ApplicationRecord
  belongs_to :student, optional: true

  validates :section, format: {with: /\A[A-Z]{3} \d{4}\z/,
                               message: " format must be 3 Capital letters a space and 4 digits"}
  validates :grade, format: {with: /\A[ABCDF]{1}[\+ -]?\z/,
                             message: " format must be 1 capital (ABCDEF) letter with a +, - or blank"}

end
 