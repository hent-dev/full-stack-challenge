class AddDetailsToLends < ActiveRecord::Migration[6.1]
  def change
    change_table(:lends, bulk: true) do |t|
      t.datetime :loan
      t.datetime :devolution
      t.belongs_to :user, foreign_key: true
    end
  end
end
