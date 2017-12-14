require 'csv'

namespace :songarchive do
  desc "Import song archive records from CSV into app database"
  task import_csv: :environment do

    CSV.foreach('/Users/hiattcollins/Documents/Crosscurrent/billboard_2015_tester.csv', headers: true) do |row|
      SongArchive.create(row.to_h)
    end

  end
end
