object false
child @tag do
  attributes :id, :name
  node :icon do
    {prefix: "/images/icons/tag_".to_url, sizes: [32, 64, 256], name: ".png"}
  end
end