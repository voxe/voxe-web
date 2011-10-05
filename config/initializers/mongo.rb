MongoMapper.config = { 
  Rails.env => {
    'uri' => ENV['MONGOHQ_URL'] || 'mongodb://localhost/joinplato_development'
  }
}

MongoMapper.connect(Rails.env)
