class Evaluation < ApplicationRecord

  validates :dotnumber, numericality: {only_integer: true}
  validates :firstname, format: {with: /\A[a-zA-Z]+\z/,
                                 message: 'First name should only have letters'}
  validates :firstname, length: {minimum: 1}
  validates :lastname, format: {with: /\A[a-zA-Z]+\z/,
                                message: 'Last name should only have letters'}
  validates :lastname, length: {minimum: 1}
  validates :dotnumber, numericality: {greater_than_or_equal_to: 1}

  validates :class_id, format: {with: /\A[A-Z]{3} \d{4}\z/,
                                message: " format must be 3 Capital letters a space and 4 digits"}

end
