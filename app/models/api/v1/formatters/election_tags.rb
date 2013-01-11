class Api::V1::Formatters::ElectionTags
  
  attr_accessor :election
  
  def initialize election
    self.election = election
  end
  
  def root_tags_json
    root_tags = ElectionTag.where({election_id: election.parent_election ? election.parent_election.id : election.id, parent_tag_id: nil}).includes(:tag)
    root_tags.collect do |election_tag|
      tag_json election_tag
    end
  end
  
  # tags: {}
  def all_tags_json
    root_tags.collect do |election_tag|
      tag_json election_tag, true
    end
  end
  
  def root_tags
    tags_hash[:root]
  end
  
  def tag_json election_tag, include_children = false
    hash = {}
    hash[:id] = election_tag.tag_id
    hash[:name] = election_tag.tag.name
    hash[:namespace] = election_tag.tag.namespace
    hash[:position] = election_tag.position
    if election_tag.root?
      hash[:icon] = {prefix: election_tag.tag.icon_prefix, sizes: election_tag.tag.icon_sizes, name: election_tag.tag.icon_name}
    end
    if include_children && !children_tags(election_tag).blank?
      hash[:tags] = children_tags(election_tag).collect { |tag| tag_json tag, include_children }
    end
    hash
  end
  
  def children_tags parent_tag
    tags_hash[parent_tag.tag_id.to_s]
  end
  
  def tags_hash
    @tags_hash ||= get_tags_hash
  end
  
  private
    def get_tags_hash
      election_tags = ElectionTag.where(election_id:(election.parent_election ? election.parent_election.id : election.id)).includes(:tag)

      tags = {} # all tags
      tags[:root] = []
      
      election_tags.each do |election_tag|
        if election_tag.parent_tag.blank?
          tags[:root] << election_tag
        else
          parent_tag_id = election_tag.parent_tag_id.to_s
          tags[parent_tag_id] = [] if tags[parent_tag_id].blank?
          tags[parent_tag_id] << election_tag
        end
      end
      
      tags
    end
  
end