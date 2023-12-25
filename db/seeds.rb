# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Spina::Resource.where(name: "posts").each do |resource|
  resource.pages.destroy_all
  resource.destroy!
end

Spina::Resource.find_or_create_by!(
  name: "posts",
  label: "Posts",
  view_template: "post",
  slug: "blog",
  order_by: :created_at
)

Spina::Resource.where(name: "features").each do |resource|
  resource.pages.destroy_all
  resource.destroy
end

features = Spina::Resource.find_or_create_by!(
  name: "features",
  label: "Features",
  view_template: "feature",
  slug: "features"
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

faq_parts = Spina::Parts::RepeaterContent.new(
  name: "faqs",
  parts: [
    Spina::Parts::Line.new(name: "question", content: "What is the difference between a trial and a subscription?"),
    Spina::Parts::MultiLine.new(name: "answer", content: "A trial is a free account that you can use to try out the service. A subscription is a paid account that you can use to create and manage your own content.")
  ]
)

content = [
  Spina::Parts::Repeater.new(name: "faqs", content: faq_parts),
  Spina::Parts::Repeater.new(name: "prices", content: price_content),
  Spina::Parts::Line.new(name: "cta_button", content: "Start a free 7 day trial"),
  Spina::Parts::Line.new(name: "cta_heading", content: "Ready to get started?"),
  Spina::Parts::MultiLine.new(name: "cta_subheading", content: "Creating your job board with Job Boardly is easy and risk-free. Explore all the features and see how they work for your job board. For free.")
]

Spina::Account.first.update!(en_content: content)

Spina::Page.find_by(name: "homepage").update!(en_content: [
  Spina::Parts::Line.new(name: "heading", content: "Launch a niche job board instantly."),
  Spina::Parts::MultiLine.new(name: "subheading", content: "Launch a fully-functional, SEO-friendly job board in minutes. Turn connecting job seekers with employers into a profitable business with our job board software."),
  Spina::Parts::Line.new(name: "social_proof_text", content: "Trusted by 100+ job boards"),
  Spina::Parts::Line.new(name: "features_heading", content: "Build the perfect, niche job board."),
  Spina::Parts::MultiLine.new(name: "features_subheading", content: "Easily launch and customize your job board with our simple, easy-to-use job board software. Tailor your board to meet the needs of your niche or industry."),
  Spina::Parts::Line.new(name: "testimonials_heading", content: "People love our job board software."),
  Spina::Parts::MultiLine.new(name: "testimonials_subheading", content: "Don't just take our word for it. Here's what Job Boardly customers have to say about using our job board software."),
  Spina::Parts::Line.new(name: "pricing_heading", content: "Simple pricing for everyone."),
  Spina::Parts::MultiLine.new(name: "pricing_subheading", content: "We offer one simple plan packed with the best features for engaging your audience, creating customer loyalty, and driving sales.")
])

Spina::Page.find_by(name: "about").update!(
  en_content: [
    Spina::Parts::Line.new(name: "heading", content: "About Job Boardly"),
    Spina::Parts::MultiLine.new(name: "subheading", content: "We're two people dedicated to building products that help people. That's why we build Job Boardly. We want to help you make money connecting talent with opportunities.")
  ]
)
