# -*- coding: utf-8 -*-
require "sqlite3"
require "json"

class ChatDataReaderSqlite3
  @@db = nil
  def self.get_last(count)
    
  end

  def self.get_from_id(last_id)
    
  end

  def self.get_all
    data_responsible(data_read).to_json
  end

  def self.get_from_to(begin_id, end_id)
    data = get_data.slice(begin_id - 1, end_id - 1);
  end

  def self.data_read
    arr = []
    execute do
      arr = @@db.execute("SELECT * FROM CHAT")
    end
    arr
  end

  def self.init
    if(!table_exist?)
      initialize_table
    end
  end

  def self.table_exist?
    arr = @@db.execute("SELECT * FROM sqlite_master WHERE TYPE='table' AND NAME='CHAT'")
    arr.length != 0
  end

  def self.initialize_table
    @@db.execute("CREATE TABLE CHAT(id integer PRIMARY KEY AUTOINCREMENT, name text, message text);")
  end

  def self.open
    if(@@db == nil)
      @@db = SQLite3::Database.new("test.db");
    end
  end

  def self.close
    if(@@db != nil)
      @@db.close
      @@db = nil
    end
  end

  def self.data_responsible(arr)
    result = []
    for var in arr do
      result.push({:id => var[0], :name => var[1], :message => var[2]})
    end
    result
  end

  def self.execute(&block)
    open
    init
    yield
    close
  end

  def self.write_message(name, message)
    execute do
      @@db.execute("INSERT INTO CHAT(name, message) VALUES('#{name}', '#{message}')")
    end
  end
end
