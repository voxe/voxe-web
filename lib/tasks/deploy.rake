namespace :deploy do
  task :setup do
    puts "== Preparing deployment (Note: it will push your master branch)"
    RAILS_ENV = "production"
    if ENV['MONGOHQ_URL'].blank?
      ENV['MONGOHQ_URL'] = "mongodb://localhost/joinplato_development"
    end
    if ENV['AWS_ACCESS_KEY_ID'].blank? || ENV['AWS_SECRET_ACCESS_KEY'].blank?
      raise "ENV: AWS_ACCESS_KEY_ID or/and AWS_SECRET_ACCESS_KEY can't be blank"
    end
    if ENV['FOG_DIRECTORY'].blank?
      raise "ENV: FOG_DIRECTORY can't be blank"
    end
    puts `git checkout master`
  end
  
  task :precompile_assets do
    puts "== Precompiling assets"
    Rake::Task['assets:precompile'].invoke
    puts "== Adding manifest.yml to your last commit"
    puts `git commit public/assets/manifest.yml -m "Add manifest.yml for deployment"`

    puts "== Removing assets"
    directory = 'public/assets'
    Dir.open(directory).each do |filename|
      next if filename.start_with?('.') or filename == 'manifest.yml'
      path = File.join(directory, filename)
      if File.directory?(path)
        FileUtils.rm_rf path
      else
        File.unlink path
      end
    end

  end
  
  task :staging => [:setup, :precompile_assets] do
    puts "== Pushing changes to Github"
    puts `git push origin master`
    puts "== Pushing voxe-staging to Heroku"
    puts `git push git@heroku.com:voxe-staging.git master`
    puts `heroku run rake cache:clear --app voxe-staging`
  end

  task :production => [:setup, :precompile_assets] do
    puts "== Pushing changes to Github"
    puts `git push production master`
    puts "== Pushing voxe to Heroku"
    puts `git push git@heroku.com:voxe.git master`
    puts `heroku run rake cache:clear --app voxe`
  end
end
