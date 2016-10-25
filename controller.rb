require "webrick"
require "./chat_servlet.rb"

server = WEBrick::HTTPServer.new(:DocumentRoot => "./", :Port => 8342, :BindAddress => "0.0.0.0")

server.mount("/", ChatServlet)

server.start
