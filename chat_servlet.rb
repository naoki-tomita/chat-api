# -*- coding: utf-8 -*-
require "webrick"
require "json"
require "./data_reader_sqlite.rb"

class ChatServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(req, res)
    res["content-type"] = "application/json; charset=utf-8"
    res.body = ChatDataReaderSqlite3.get_all;
  end

  def do_POST(req, res)
    post_body = JSON.parse(req.body)
    puts post_body
    if(post_body.key?("name") && post_body.key?("message"))
      ChatDataReaderSqlite3.write_message(post_body["name"], post_body["message"])
      res.status = 201
    else
      res.status = 401
    end
  end
end
