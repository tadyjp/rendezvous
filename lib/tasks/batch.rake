
namespace :batch do

  desc 'Tagに関連するPostのcounter_cacheの再生成'
  task reset_counters: :environment do
    Tag.all.each{|t| Tag.reset_counters(t.id, :posts) }
  end

end


