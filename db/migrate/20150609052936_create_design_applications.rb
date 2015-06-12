class CreateDesignApplications < ActiveRecord::Migration
  def change
    create_table :design_applications do |t|
      t.string :name
      t.string :address
      t.string :email
      t.string :phone
      t.string :work_address
      t.text :description
      t.date :start_date
      t.date :end_date

      t.timestamps null: false
    end
  end
end
