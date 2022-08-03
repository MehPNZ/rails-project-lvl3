# frozen_string_literal: true

class AddStateToBulletins < ActiveRecord::Migration[6.1]
  def change
    add_column :bulletins, :state, :string
  end
end
