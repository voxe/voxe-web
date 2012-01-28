namespace :deploy do
  task :setup do
    puts "== Preparing deployment (Note: it will push your master branch)"
    RAILS_ENV = "production"
    if ENV['MONGOHQ_URL'].blank?
      ENV['MONGOHQ_URL'] = "mongodb://localhost/joinplato_development"
    end
  end
  
  task :precompile_assets do
    puts "== Precompiling assets"
    Rake::Task['assets:precompile'].invoke
  end
  
  task :staging => [:setup, :precompile_assets] do
    puts "== Pushing changes to Github"
    puts `git push origin master`
    puts "== Pushing voxe-staging to Heroku"
    puts `git push git@heroku.com:voxe-staging.git master`
  end

  task :production => [:setup, :precompile_assets] do
    puts "== Pushing changes to Github"
    puts `git push production master`
    puts "== Pushing voxe to Heroku"
    puts `git push git@heroku.com:voxe.git master`
  end
end
