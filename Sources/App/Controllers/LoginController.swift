import Vapor
import VaporInertiaAdapter

struct LoginController{
    public init() {}
    
    public func show(req: Request) -> InertiaResponse {
        
        return req.application.inertia.render("Auth/Login", [:])
    }
    
    public func login(req: Request) -> String {
        return "Done"
    }
}
