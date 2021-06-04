# csv ファイルを扱うために必要
require "csv"
# 名前空間 => import
namespace :import_csv do
# タスクの説明
  desc "CSV データをインポートするタスク"

  task users: :environment do
    path = "db/csv_data/csv_data.csv"
    list = []
    CSV.foreach(path, headers: true) do |row|
      list << row.to_h
    end
    puts "インポート開始"
    begin
      User.transaction do
        User.create!(list)
      end
      puts "インポート完了！".green
    rescue StanderdError => e
      puts "#{e.class}: #{e.message}".red
      puts "-------------------------"
      puts e.backtrace
      puts "-------------------------"
      puts "インポートに失敗".red
    end
  end

end
