class ItemsRepository < DefaultRepository
  def update_link_and_image(attributes)
    item = find_or_initialize(name: attributes[:name])
    item.link_url = attributes[:link_url]
    item.image_url = attributes[:image_url]
    item.save if item.changed?

    item
  end
end
