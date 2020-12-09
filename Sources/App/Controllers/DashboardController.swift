import Vapor
import VaporInertiaAdapter

struct DashboardController {
    
    init() { }
    
    func index(request: Request) throws -> EventLoopFuture<InertiaResponse> {
        return User.query(on: request.db)
            .with(\.$account)
            .first()
            .unwrap(or: Abort(.notFound))
            .flatMapThrowing { user -> InertiaResponse in
                return request.application.inertia.render("Dashboard/Index", [
                    "user": "user-json-here"
                ])
            }
    }
    
    

}
