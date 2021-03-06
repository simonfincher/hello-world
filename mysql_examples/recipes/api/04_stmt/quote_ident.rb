#!/usr/bin/ruby -w
# quote_ident.rb - demonstrate identifier quoting in Ruby

require "Cookbook"

begin
  dbh = Cookbook.connect
rescue DBI::DatabaseError => e
  puts "Cannot connect to server"
  puts "Error code: #{e.err}"
  puts "Error message: #{e.errstr}"
  exit(1)
end

#@ _QUOTE_IDENTIFIER_
def quote_identifier(ident)
  return "`" + ident.gsub(/`/, "``") + "`"
end
#@ _QUOTE_IDENTIFIER_

# This example uses database, table, and column names as identifiers,
# and quotes them as such

db_name = "some db"
tbl_name = "some`table"
col_name = "some column`name"

#@ _USE_
stmt = sprintf("SELECT %s FROM %s.%s",
                quote_identifier(col_name),
                quote_identifier(db_name),
                quote_identifier(tbl_name))
puts stmt

# This example uses database and table names as data values,
# and quotes them as such

db_name = "cookbook"
tbl_name = "profile"

#@ _IDENT_AS_DATA_
names = dbh.select_all(
               "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS
                WHERE TABLE_SCHEMA = ? AND TABLE_NAME = ?",
               db_name, tbl_name)
#@ _IDENT_AS_DATA_
names.each do |name|
   puts name
end


dbh.disconnect
