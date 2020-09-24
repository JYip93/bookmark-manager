require 'database_connection'

describe DatabaseConnection do
    describe '#setup' do
        it 'Take database name and setup a connnection to it' do
            expect(DatabaseConnection.setup("bookmark_manager_test")).to be_kind_of(PG::Connection)
        end
    end

    describe '#query' do
        it 'When querying it should execute SQL query string' do
            DatabaseConnection.setup("bookmark_manager_test")
            expect(DatabaseConnection.query("SELECT * FROM bookmarks;")).to be_kind_of(PG::Result)
        end
    end


end