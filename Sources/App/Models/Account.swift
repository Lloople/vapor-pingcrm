import Vapor
import Fluent

final class Account: Model, Content {
    static let schema = "accounts"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    @Children(for: \.$account)
    var users: [User]
    
    @Children(for: \.$account)
    var organizations: [Organization]
    
    @Children(for: \.$account)
    var contacts: [Contact]
    
    init() { }
    
    init(id: UUID? = nil, name: String) {
        self.id = id
        self.name = name
    }
}
