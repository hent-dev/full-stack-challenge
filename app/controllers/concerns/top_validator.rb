class TopValidator < ActiveModel::Validator
    def validate(record)
        if record.devolution != nil && record.devolution < record.created_at
            puts "devolution: #{record.devolution}"
            puts "created_at: #{record.created_at}"
            record.errors[:base] << "The return date cannot be less than loan date"
        elsif record.devolution != nil && (record.devolution.year * 12 + record.devolution.month) - (record.devolution.year * 12 + record.devolution.month) >= 6
            record.errors[:base] << "The datetime cannot be greater of six months"
        end
        
        lends = Lend.where({ user_id: record.user_id, devolution: nil})

        if lends.size >= 2
            record.errors[:base] << "The user has more than 2 loans not closed"
        end
    end
end