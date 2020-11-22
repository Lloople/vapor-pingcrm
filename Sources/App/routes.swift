import Fluent
import Vapor

func routes(_ app: Application) throws {
    
    app.get(use: DashboardController().index)
    
    app.get("500") { req throws -> String in
        throw Abort(.internalServerError, reason: "Something went wrong")
    }
}
