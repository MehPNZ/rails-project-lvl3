class AddAasmStateToBulletins < ActiveRecord::Migration[6.1]
  def change
    add_column :bulletins, :aasm_state, :string
  end
end
