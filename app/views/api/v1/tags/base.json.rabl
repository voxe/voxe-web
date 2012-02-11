attributes :id, :name, :namespace
node :icon do |tag|
  {prefix: tag.icon_prefix, sizes: tag.icon_sizes, name: tag.icon_name}
end