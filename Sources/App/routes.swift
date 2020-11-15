import Fluent
import Vapor

func routes(_ app: Application) throws {
    
    app.get(use: DashboardController().index)

}
