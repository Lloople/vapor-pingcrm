import Fluent
import FluentSQLiteDriver
import Vapor
import Leaf
import LeafErrorMiddleware
import VaporInertiaAdapter

public func configure(_ app: Application) throws {
    
    configureMiddlewares(app)
    
    app.views.use(.leaf)

    configureDatabase(app)
    
    try migrate(app)

    try routes(app)
}

public func configureMiddlewares(_ app: Application) {
    app.middleware.use(LeafErrorMiddleware())
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    app.middleware.use(app.sessions.middleware)
    app.middleware.use(User.sessionAuthenticator())
}

public func configureDatabase(_ app: Application) {
    app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)
}

public func migrate(_ app: Application) throws {
    app.migrations.add(CreatePasswordResetsTable())
    app.migrations.add(CreateAccountsTable())
    app.migrations.add(CreateUsersTable())
    app.migrations.add(CreateOrganizationsTable())
    app.migrations.add(CreateContactsTable())
    app.migrations.add(SeedTables())
}
