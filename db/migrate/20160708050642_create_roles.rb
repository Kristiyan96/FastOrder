# frozen_string_literal: true
class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.references :restaurant, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
