# seedsファイルの分割適用のためのタスク。
# db/seeds.rbにseedsデータをすべてまとめず分割して適用するときに使う。

# db/seeds直下にseedsファイルを配置しておく。
# db/seeds/*.rbのすべてのseedsファイルを読み込んでタスク化する。
# 例えば、db/seeds/user.rbを実行する場合にはrake db:seed:userとターミナルで打つ。
Dir.glob(File.join(Rails.root, 'db', 'seeds', '*.rb')).each do |file|
  desc "Load the seed data from db/seeds/#{File.basename(file)}."
  task "db:seed:#{File.basename(file).gsub(/\..+$/, '')}": :environment do
    load(file)
  end
end

# db/seeds/*.rbのすべてのseedsファイルを実行する。
# db:seed:allとターミナルで打つ。
desc "Load all the seed data from db/seeds directory"
task "db:seed:all": :environment do
  Dir.glob(File.join(Rails.root, 'db', 'seeds', '*.rb')).each do |file|
    load(file)
  end
end
