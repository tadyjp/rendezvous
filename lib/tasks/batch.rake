
namespace :batch do

  desc 'Tagに関連するPostのcounter_cacheの再生成'
  task reset_counters: :environment do
    puts "\t[START] batch:reset_counters"
    Tag.all.each { |t| Tag.reset_counters(t.id, :posts) }
    puts "\t[FINISH] batch:reset_counters"
  end

end
