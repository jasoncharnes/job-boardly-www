# Theme configuration file
# ========================
# This file is used for all theme configuration.
# It's where you define everything that's editable in Spina CMS.

heroicons = File.join(Gem.loaded_specs["heroicon"].full_gem_path, "app/assets/images/heroicon/outline/**/*")
  .then { Dir[_1] }
  .map { File.basename(_1, ".svg") }

Spina::Theme.register do |theme|
  # All views are namespaced based on the theme's name
  theme.name = "default"
  theme.title = "Default theme"

  # Parts
  # Define all editable parts you want to use in your view templates
  #
  # Built-in part types:
  # - Line
  # - MultiLine
  # - Text (Rich text editor)
  # - Image
  # - ImageCollection
  # - Attachment
  # - Option
  # - Repeater
  theme.parts = [
    {name: "content", title: "Body", hint: "Your main content", part_type: "Spina::Parts::Text"},
    {name: "text", title: "Text", part_type: "Spina::Parts::Line"},
    {name: "summary", title: "Summary", part_type: "Spina::Parts::MultiLine"},
    {name: "heading", title: "Heading", part_type: "Spina::Parts::Line"},
    {name: "subheading", title: "Subheading", part_type: "Spina::Parts::MultiLine"},
    {name: "social_proof_text", title: "Social proof", part_type: "Spina::Parts::Line"},
    {name: "features_heading", title: "Features heading", part_type: "Spina::Parts::Line"},
    {name: "features_subheading", title: "Features subheading", part_type: "Spina::Parts::MultiLine"},
    {name: "pricing_heading", title: "Pricing heading", part_type: "Spina::Parts::Line"},
    {name: "pricing_subheading", title: "Pricing subheading", part_type: "Spina::Parts::MultiLine"},
    {name: "icon", title: "Icon", options: heroicons, part_type: "Spina::Parts::Option"},
    {name: "testimonials_heading", title: "Testimonials heading", part_type: "Spina::Parts::Line"},
    {name: "testimonials_subheading", title: "Testimonials subheading", part_type: "Spina::Parts::MultiLine"},
    {name: "cta_heading", title: "CTA heading", part_type: "Spina::Parts::Line"},
    {name: "cta_subheading", title: "CTA subheading", part_type: "Spina::Parts::MultiLine"},
    {name: "cta_button", title: "CTA button", part_type: "Spina::Parts::Line"},
    {name: "screenshot", title: "Screenshot", part_type: "Spina::Parts::Image"},
    {name: "question", title: "Question", part_type: "Spina::Parts::Line"},
    {name: "answer", title: "Answer", part_type: "Spina::Parts::MultiLine"},
    {name: "faqs", title: "FAQ", parts: %w[question answer], part_type: "Spina::Parts::Repeater"},
    {name: "banner_text", title: "Banner text", part_type: "Spina::Parts::Line"},
    {name: "banner_link", title: "Banner link", part_type: "Spina::Parts::Line"},
    {name: "custom_code", title: "Custom code", part_type: "Spina::Parts::MultiLine"},
    {name: "published_at", title: "Published at", part_type: "Spina::Parts::Line", hint: "YYYY-MM-DD"},
    {name: "avatar", title: "Avatar", part_type: "Spina::Parts::Image"},
    {name: "name", title: "Name", part_type: "Spina::Parts::Line"},
    {name: "company", title: "Company", part_type: "Spina::Parts::Line"},
    {name: "quote", title: "Quote", part_type: "Spina::Parts::MultiLine"},
    {name: "social_proof_avatars", title: "Social proof avatars", parts: %w[avatar], part_type: "Spina::Parts::Repeater"},
    {name: "testimonials", title: "Testimonials", parts: %w[name avatar company quote], part_type: "Spina::Parts::Repeater"},
    # Pricing-related fields
    {name: "plan", title: "Plan ID", part_type: "Spina::Parts::Line"},
    {name: "monthly_price", title: "Monthly price", part_type: "Spina::Parts::Line"},
    {name: "yearly_price", title: "Yearly price", part_type: "Spina::Parts::Line"},
    {name: "price_features", title: "Price features", parts: %w[text], part_type: "Spina::Parts::Repeater"},
    {name: "prices",
     title: "Prices",
     parts: %w[heading subheading monthly_price yearly_price plan price_features],
     part_type: "Spina::Parts::Repeater"}
  ]

  # View templates
  # Every page has a view template stored in app/views/my_theme/pages/*
  # You define which parts you want to enable for every view template
  # by referencing them from the theme.parts configuration above.
  theme.view_templates = [
    {name: "homepage",
     title: "Homepage",
     parts: %w[heading subheading social_proof_text social_proof_avatars features_heading features_subheading
       testimonials_heading testimonials_subheading testimonials pricing_heading pricing_subheading]},
    {name: "show", title: "Page", parts: %w[content]},
    {name: "feature", title: "Feature", parts: %w[icon summary screenshot content]},
    {name: "about", title: "About", parts: %w[heading subheading]},
    {name: "post", title: "Blog post", parts: %w[published_at summary content]},
    {name: "blog", title: "Blog list", parts: %w[heading subheading]}
  ]

  # Custom pages
  # Some pages should not be created by the user, but generated automatically.
  # By naming them you can reference them in your code.
  theme.custom_pages = [
    {name: "homepage", title: "Homepage", deletable: false, view_template: "homepage"},
    {name: "about", title: "About", deletable: false, view_template: "about"},
    {name: "blog", title: "Blog", deletable: false, view_template: "blog"}
  ]

  # Navigations (optional)
  # If your project has multiple navigations, it can be useful to configure multiple
  # navigations.
  theme.navigations = [
    {name: "main", label: "Main navigation"},
    {name: "footer", label: "Footer navigation"}
  ]

  # Layout parts (optional)
  # You can create global content that doesn't belong to one specific page. We call these layout parts.
  # You only have to reference the name of the parts you want to have here.
  theme.layout_parts = [
    "cta_button", "cta_heading", "cta_subheading",
    "banner_text", "banner_link", "custom_code",
    "faqs", "prices"
  ]

  # Resources (optional)
  # Think of resources as a collection of pages. They are managed separately in Spina
  # allowing you to separate these pages from the 'main' collection of pages.
  theme.resources = []

  # Plugins (optional)
  theme.plugins = []

  # Embeds (optional)
  theme.embeds = []
end
