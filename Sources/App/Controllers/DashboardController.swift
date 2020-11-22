import Vapor
import VaporInertiaAdapter

struct DashboardController {
    
    init() { }
    
    func index(request: Request) throws -> EventLoopFuture<Response> {
        
        let component = Component(name: "Dashboard/Index", properties: [
            "errors": [:],
            "auth": [
                "user": [
                    "id": 1,
                    "first_name": "John",
                    "last_name": "Doe",
                    "email": "johndoe@example.com",
                    "role": nil,
                    "account": [
                        "id": 1,
                        "name": "Acme Corporation"
                    ]
                ]
            ],
            "flash": [
                "success": nil,
                "errors": nil
            ]
        ])
        
        return try Inertia.instance().render(for: request, with: component)
    }
}
