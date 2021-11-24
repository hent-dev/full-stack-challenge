class LoanDevolutionValidator < ActiveModel::Validator
  def validate(record)
    unless record.devolution.nil?
      months = ((record.devolution.year * 12 + record.devolution.month) -
        (record.created_at.year * 12 + record.created_at.month))

      if record.devolution < record.created_at
        record.erros[:base] << 'The return date cannot be less than loan date'
      elsif months >= 6
        record.erros[:base] << 'The datetime cannot be greater of six months'
      end
    end

    lends = Lend.where({ user_id: record.user_id, devolution: nil })

    if lends.size >= 2 # check if exists two or more lends not closed
      record.errors[:base] << 'The user has more than 2 loans not closed'
    end
  end
end