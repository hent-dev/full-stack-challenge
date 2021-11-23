class Lend < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates_with LoanDevolutionValidator
end