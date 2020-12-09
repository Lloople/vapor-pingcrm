import Vapor
import VaporInertiaAdapter

struct UsersController {
    
    public init() {}
    
    public func edit(req: Request) throws -> EventLoopFuture<InertiaResponse> {
        
        return User.find(try req.inputUUID("userId"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .map { user -> InertiaResponse in
                req.application.inertia.render("Users/Edit", ["user": "user-json-here"])
            }
    }
}
