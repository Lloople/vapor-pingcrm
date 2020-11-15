import Vapor
import Fluent

final class Contact: Model, Content {
    static let schema = "contacts"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "account_id")
    var account: Account
    
    @OptionalParent(key: "organization_id")
    var organization: Organization?
    
    @Field(key: "first_name")
    var firstName: String
    
    @Field(key: "last_name")
    var lastName: String
    
    @OptionalField(key: "email")
    var email: String?
    
    @OptionalField(key: "phone")
    var phone: String?
    
    @OptionalField(key: "address")
    var address: String?
    
    @OptionalField(key: "city")
    var city: String?
    
    @OptionalField(key: "region")
    var region: String?
    
    @OptionalField(key: "country")
    var country: String?
    
    @OptionalField(key: "postal_code")
    var postalCode: String?
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    @Timestamp(key: "deleted_at", on: .delete)
    var deletedAt: Date?
    
    init() { }
    
    init(id: UUID? = nil, firstName: String, lastName: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
    }
}
