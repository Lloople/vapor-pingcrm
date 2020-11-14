import Fluent

struct CreateAccountsTable: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("accounts")
            .id()
            .field("name", .string, .required)
            .field("created_at", .datetime, .required)
            .field("updated_at", .datetime, .required)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("accounts").delete()
    }
}
