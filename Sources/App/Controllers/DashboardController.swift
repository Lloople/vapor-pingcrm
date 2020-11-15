import Vapor
import VaporInertiaAdapter

struct DashboardController {
    
    init() { }
    
    func index(request: Request) throws -> EventLoopFuture<Response> {
        
        let component = Component(name: "Dashboard/Index", properties: [:])
        
        return try Inertia.instance().render(for: request, with: component)
    }
}
