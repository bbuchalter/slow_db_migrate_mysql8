#!/usr/bin/env ruby

require 'pathname'
require 'securerandom'

current_file_path = Pathname.new('db/migrate/20200219200125_create_books.rb')

400.times do
  current_date = Integer(current_file_path.basename.to_s.split('_').first)
  next_date = current_date + 1
  klass_name_randomization = ('a'..'z').to_a.shuffle[0,8].join
  next_file_path = Pathname.new("db/migrate/#{next_date}_create_books#{klass_name_randomization}.rb")
  next_file_content = <<~MIGRATION
  class CreateBooks#{klass_name_randomization} < ActiveRecord::Migration[6.0]
    def change
      create_table :books_#{next_date} do |t|
        t.string :title
        t.string :author
        t.string :isbn
        t.string :page_count

        t.timestamps
      end
    end
  end
  MIGRATION
  File.write(next_file_path, next_file_content)
  current_file_path = next_file_path
end