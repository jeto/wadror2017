class CreateStyles < ActiveRecord::Migration
  def change
    create_table :styles do |t|
      t.string :name, null: false
      t.text :description, null: false

      t.timestamps null: false
    end

    Beer.all.pluck(:style).uniq.each do |style|
      Style.create(name: style, description:'')
    end

    change_table :beers do |t|
      t.rename :style, :old_style
      t.integer :style_id
      t.references :style, index: true, foreign_key: true
    end

    Beer.all.each do |beer|
      Style.all.each do |style|
        if style.name == beer.old_style
          beer.style_id = style.id
          beer.save
        end
      end
    end

    change_table :beers do |t|
      t.remove :old_style
    end
  end
end
