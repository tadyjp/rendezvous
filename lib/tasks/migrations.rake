
namespace :migrations do

  desc '001 nicknameを自動付与'
  task task_001_user_nickname: :environment do
    User.all.each do |_user|
      next if _user.nickname.present?

      new_nickname = (('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a).shuffle[0..4].join
      _user.update_attributes!(nickname: new_nickname)
    end
  end

end
