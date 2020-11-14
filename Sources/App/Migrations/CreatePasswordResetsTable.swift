import Fluent

struct CreatePasswordResetsTable: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("password_resets")
            .id()
            .field("email", .string, .required)
            .field("token", .string, .required)
            .field("created_at", .datetime, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("password_resets").delete()
    }
}
