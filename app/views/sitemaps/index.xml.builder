xml.instruct! :xml, version: "1.0"

xml.tag! "urlset", "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do
  @pages.each do |page|
    xml.url do
      xml.loc "https://www.jobboardly.com/#{page.materialized_path}"
      xml.lastmod page.updated_at.xmlschema
    end
  end
end
