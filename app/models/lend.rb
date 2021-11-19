class Lend < ApplicationRecord
  belongs_to :book
  include ActiveModel::Validations
  validates_with TopValidator
end