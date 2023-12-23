# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Spina::Resource.where(name: "features") do |resource|
  resources.pages.destroy_all
  resource.destroy
end

features = Spina::Resource.find_or_create_by!(
  name: "features",
  label: "Features",
  view_template: "feature",
  slug: {en: "features"}
)

features.pages.destroy_all

seeds = YAML.load_file(Rails.root.join("db", "seeds.yml"))

seeds["features"].each do |feature|
  features.pages.create!(
    title: feature["title"],
    view_template: "feature",
    en_content: feature["en_content"].map do |part|
      part[0].constantize.new(**part[1])
    end
  )
end

price_content = seeds["prices"].map do |price|
  parts = [
    Spina::Parts::Line.new(name: "heading", content: price["heading"]),
    Spina::Parts::MultiLine.new(name: "subheading", content: price["subheading"]),
    Spina::Parts::Line.new(name: "monthly_price", content: price["monthly_price"]),
    Spina::Parts::Line.new(name: "yearly_price", content: price["yearly_price"]),
    Spina::Parts::Repeater.new(name: "price_features", content: price["price_features"].map {
      Spina::Parts::RepeaterContent.new(
        name: "price_features",
        parts: [Spina::Parts::Line.new(name: "text", content: _1)]
      )
    })
  ]

  Spina::Parts::RepeaterContent.new(name: "prices", parts: parts)
end

price_content = Spina::Parts::Repeater.new(name: "prices", content: price_content)

Spina::Account.first.update!(en_content: price_content)
