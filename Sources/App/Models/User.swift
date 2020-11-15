import Vapor
import Fluent

final class User: Model, Content {
    static let schema = "users"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "account_id")
    var account: Account
    
    @Field(key: "first_name")
    var firstName: String
    
    @Field(key: "last_name")
    var lastName: String
    
    @Field(key: "email")
    var email: String
    
    @OptionalField(key: "password")
    var password: String?
    
    @Field(key: "owner")
    var owner: Bool

    @OptionalField(key: "photo_path")
    var photoPath: String?
    
    @OptionalField(key: "remember_token")
    var rememberToken: String?
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    @Timestamp(key: "deleted_at", on: .delete)
    var deletedAt: Date?
    
    init() { }
    
    init(id: UUID? = nil, firstName: String, lastName: String, email: String, password: String?, owner: Bool = false) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.owner = owner
        
        if password != nil {
            self.password = try? Bcrypt.hash(password!)
        }
    }
}
