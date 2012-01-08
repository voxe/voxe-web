module PlatformHelper
  
  def twitter_intent_url
    root = "https://twitter.com/intent/tweet"
    params = {}
    params["text"] = "Comparer les candidats sur http://voxe.org"
    params["related"] = Settings.twitter
    
    root + "?" + params.to_query
  end
  
end