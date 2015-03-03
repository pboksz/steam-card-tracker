class ItemsRepository < DefaultRepository
  def update_link_and_image(name, link_url, image_url)
    item = find_or_initialize(name: name)
    item.link_url = link_url
    item.image_url = image_url
    item.save if item.changed?

    item
  end
end
