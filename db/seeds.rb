# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Product.delete_all

Product.create!(title: 'Chocolate Bar',
    description: 
      %{<p>
          This chocolate bar is made from 70% cacao.
            </p>
      },
    image_url: 'lindt.jpg',
    price: 34.98)

