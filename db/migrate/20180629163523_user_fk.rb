class UserFk < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :users,:materials
  end
end
