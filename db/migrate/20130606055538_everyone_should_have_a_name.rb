class EveryoneShouldHaveAName < ActiveRecord::Migration
  def change
    User.all.each do |user|
      if user.name.blank?
        user.name = "Usuario #{user.id}"
        if user.email.blank?
          user.email = "sample_email#{rand(999999999)}@example.com"
        end
        user.save!
      end
    end
  end
end
