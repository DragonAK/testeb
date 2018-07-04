class AddNameUniquenessIndex < ActiveRecord::Migration[5.2]
  def change
    add_index(:materials, :name, {:unique=>true})
  end
end
