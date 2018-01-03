require 'csv'

# Rake task to import data from song archive CSV file into song_archive table in db.
# To run, type the following into the command line: $ rake songarchive:import_csv

namespace :songarchive do
  desc "Import song archive records from CSV into app database"
  task import_csv: :environment do

    CSV.foreach('/Users/hiattcollins/workspace/capstone-back-end/crosscurrent/db/csv/billboard_1965_to_2015_analyzed.csv', headers: true) do |row|
      SongArchive.create(row.to_h)
    end

  end
end
