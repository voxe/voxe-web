namespace :deploy do
  task :setup do
    puts "== Preparing deployment (Note: it will push your master branch)"
    RAILS_ENV = "production"
    if ENV['MONGOHQ_URL'].blank?
      ENV['MONGOHQ_URL'] = "mongodb://localhost/joinplato_development"
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
  end

  task :production => [:setup, :precompile_assets] do
    puts "== Pushing changes to Github"
    puts `git push production master`
    puts "== Pushing voxe to Heroku"
    puts `git push git@heroku.com:voxe.git master`
  end
end
