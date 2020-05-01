class Student < ApplicationRecord
  has_many :grades, dependent: :destroy
  accepts_nested_attributes_for :grades, allow_destroy: true, reject_if: :all_blank

  validates :dotnumber, numericality: {only_integer: true}
  validates :firstname, format: {with: /\A[a-zA-Z]+\z/,
                                 message: 'First name should only have letters'}
  validates :firstname, length: {minimum: 1}
  validates :lastname, format: {with: /\A[a-zA-Z]+\z/,
                                message: 'Last name should only have letters'}
  validates :lastname, length: {minimum: 1}
  validates :dotnumber, numericality: {greater_than_or_equal_to: 1}
end
