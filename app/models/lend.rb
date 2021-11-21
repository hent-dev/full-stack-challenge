class Lend < ApplicationRecord
  belongs_to :book
  belongs_to :user
  include ActiveModel::Validations
  validates_with TopValidator
end