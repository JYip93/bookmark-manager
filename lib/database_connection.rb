require 'pg'

class DatabaseConnection

    attr_reader :connection

    def self.setup(database)
        @connection = PG.connect(dbname: database)
    end

    def self.query(sql_string)
        @connection.exec(sql_string)
    end

end