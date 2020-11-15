import Fluent

struct CreateUsersTable: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("users")
            .id()
            .field("account_id", .uuid, .required, .references("accounts", "id"))
            .field("first_name", .string, .required)
            .field("last_name", .string, .required)
            .field("email", .string, .required)
            .field("password", .string)
            .field("owner", .bool, .required)
            .field("photo_path", .string)
            .field("remember_token", .string)
            .field("created_at", .datetime, .required)
            .field("updated_at", .datetime, .required)
            .field("deleted_at", .datetime)
            .unique(on: "email")
            // TODO: How to add indexes in SQLite ?
            // .constraint(.custom("INDEX (account_id)"))
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("users").delete()
    }
}
