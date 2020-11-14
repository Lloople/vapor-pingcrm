import Fluent

struct CreateOrganizationsTable: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("organizations")
            .id()
            .field("account_id", .uuid, .required, .references("accounts", "id"))
            .field("name", .string, .required)
            .field("email", .string)
            .field("phone", .string)
            .field("address", .string)
            .field("city", .string)
            .field("region", .string)
            .field("country", .string)
            .field("postal_code", .string)
            .field("created_at", .datetime, .required)
            .field("updated_at", .datetime, .required)
            .field("deleted_at", .datetime)
            // TODO: How to add indexes in SQLite ?
            // .constraint(.custom("INDEX account_id"))
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("organizations").delete()
    }
}
