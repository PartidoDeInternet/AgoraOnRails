namespace :agoraonrails do
  desc "basic rake task to get up and running"
  task :setup => :environment do
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:seed'].invoke
    Rake::Task['scrapper:scrape'].invoke
  end

  desc "Preparation of version 2.0"
  task :prepare_update => :environment do
    User.find_each do |user|
      User.reset_counters(user.id, :represented_users)
    end
  end

end