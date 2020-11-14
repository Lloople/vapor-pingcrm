import Fluent

struct CreateContactsTable: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("contacts")
            .id()
            .field("account_id", .uuid, .required, .references("accounts", "id"))
            .field("organization_id", .uuid, .references("organizations", "id"))
            .field("first_name", .string, .required)
            .field("last_name", .string, .required)
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
            // .constraint(.custom("INDEX account_id, organization_id"))
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("contacts").delete()
    }
}
