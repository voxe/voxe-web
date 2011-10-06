MongoMapper.config = { 
  Rails.env => {
    'uri' => ENV['MONGOHQ_URL'] || "mongodb://localhost/joinplato_#{Rails.env}"
  }
}

MongoMapper.connect(Rails.env)
