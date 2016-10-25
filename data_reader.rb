# -*- coding: utf-8 -*-
require "csv"
require "json"

class ChatDataReader
  def self.get_last(count)
    length = data_length
    get_from_to(length - count, length - 1)
  end

  def self.get_from_id(last_id)
    length = data_length
    get_from_to(last_id, length - 1)
  end

  def self.get_data
    CSV.read("data.csv");
  end

  def self.get_all
    data = get_data
    data_responsible(data).to_json
  end

  def self.get_from_to(begin_id, end_id)
    data = get_data.slice(begin_id - 1, end_id - 1);
  end

  def self.data_responsible(arr)
    result = []
    for var in arr do
      result.push({:id => var[0], :name => var[1], :message => var[2]})
    end
    result
  end

  def self.data_length
    get_data.length
  end

  def self.write_message(name, message)
    length = data_length
    File.open("./data.csv", "a") do |csv|
      csv.puts "#{length + 1},#{name},#{message}\n"
    end
  end
end
