xml.instruct!
xml.urlset 'xmlns' => 'http://www.sitemaps.org/schemas/sitemap/0.9' do
  xml.url do
    xml.loc root_url(only_path: false)
    xml.changefreq 'monthly'
    xml.priority 1
    xml.lastmod Date.today.to_s
  end
end
