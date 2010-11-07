namespace :agoraonrails do
  desc "basic rake tasks to get up and running"
  task :setup => :environment do
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:seed'].invoke
    Rake::Task['scrapper:scrape'].invoke
    Rake::Task['proposals:promote'].invoke
  end
end