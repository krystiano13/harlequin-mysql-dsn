#!/usr/bin/env ruby

begin 
  if ARGV[0].nil?
    raise ArgumentError
  end

  dsn = ARGV[0].dup
rescue ArgumentError
  puts "Argument error: You need to pass 1 argument (DSN)"
  exit!
end


dsn = dsn.sub('mysql://', '')
         .split("serverVersion=")[0]
         .sub('?', '')

begin
  credentials = dsn.split('@')[0]
  server = dsn.split('@')[1]

  USERNAME = credentials.split(':')[0]
  PASSWORD = credentials.split(':')[1]

  DBNAME = server.split('/')[1]
  HOST = server.split('/')[0].split(':')[0]
  PORT = server.split('/')[0].split(':')[1]
rescue
  puts "ArgumentError: Invalid DSN format"
  exit!
end

# build the command

cmd = "harlequin -a mysql -h #{HOST} -p #{PORT} -U #{USERNAME} --password #{PASSWORD} --database #{DBNAME}"
puts cmd

exit!

