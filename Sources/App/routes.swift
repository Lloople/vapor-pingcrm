import Fluent
import Vapor

func routes(_ app: Application) throws {
    
    try routesAuth(app)
    
    app.get(use: DashboardController().index)
    
    app.get("500") { req throws -> String in
        throw Abort(.internalServerError, reason: "Something went wrong")
    }
    
    let protected = app.grouped(User.inertiaRedirectMiddleware(path: "/login"))
    protected.get("users", ":userId", "edit", use: UsersController().edit)
}

func routesAuth(_ app: Application) throws {
    app.get("login", use: LoginController().show)
    app.post("login", use: LoginController().login)
}
