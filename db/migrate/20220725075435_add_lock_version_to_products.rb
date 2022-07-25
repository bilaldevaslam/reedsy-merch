# frozen_string_literal: true

class AddLockVersionToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :lock_version, :integer
  end
end
