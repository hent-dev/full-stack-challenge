class AddDetailsToLends < ActiveRecord::Migration[6.1]
  def change
    add_column :lends, :loan, :datetime
    add_column :lends, :devolution, :datetime
    add_reference :lends, :user, foreign_key: true
  end
end
