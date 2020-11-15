import Fluent
import Fakery
import Vapor

struct SeedTables: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        
        let faker = Faker(locale: "en-US")
        
        return createAccount(database).flatMap { account -> EventLoopFuture<[Contact]> in
            
            createOwner(database, account)
            
            createUsers(database, account, faker)
            
            return createOrgs(database, account, faker).flatMap { orgs -> EventLoopFuture<[Contact]> in
                return createContacts(database, account, faker, orgs)
            }
        }.transform(to: ())
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
     
        return database.eventLoop.future()
    }
    
    func createAccount(_ database: Database) -> EventLoopFuture<Account> {
        let acc = Account(name: "Acme Corporation")
        
        return acc.create(on: database).transform(to: acc)
    }
    
    func createOwner(_ database: Database, _ account: Account) -> EventLoopFuture<User> {
        
        let user = User(
            firstName: "John",
            lastName: "Doe",
            email: "johndoe@example.com",
            password: "secret",
            owner: true
        )
        
        return account.$users.create(user, on: database).transform(to: user)
    }
    
    func createUsers(_ database: Database, _ account: Account, _ faker: Faker) -> EventLoopFuture<[User]> {
        return (1...5).map{ _ -> EventLoopFuture<User> in
            let user = User(
                firstName: faker.name.firstName(),
                lastName: faker.name.lastName(),
                email: faker.internet.safeEmail(),
                password: faker.internet.password(),
                owner: false
            )
            
            return account.$users.create(user, on: database).transform(to: user)
        }.flatten(on: database.eventLoop)
    }
        
    func createOrgs(_ database: Database, _ account: Account, _ faker: Faker) -> EventLoopFuture<[Organization]> {
        
        return (1...100).map { _ -> EventLoopFuture<Organization> in
            let org = Organization(
                name: faker.company.name(),
                email: faker.internet.safeEmail()
            )
            
            org.phone = faker.phoneNumber.cellPhone()
            org.address = faker.address.streetAddress()
            org.city = faker.address.city()
            org.region = faker.address.state()
            org.country = "US"
            org.postalCode = faker.address.postcode()
            
            return account.$organizations.create(org, on: database).transform(to: org)
        }.flatten(on: database.eventLoop)
    }

    func createContacts(_ database: Database, _ account: Account, _ faker: Faker, _ orgs: [Organization]) -> EventLoopFuture<[Contact]> {

        return (1...100).map { _ -> EventLoopFuture<Contact> in

            let contact = Contact(
                firstName: faker.name.firstName(),
                lastName: faker.name.lastName()
            )

            contact.email = faker.internet.safeEmail()
            contact.phone = faker.phoneNumber.cellPhone()
            contact.address = faker.address.streetAddress()
            contact.city = faker.address.city()
            contact.region = faker.address.state()
            contact.country = "US"
            contact.postalCode = faker.address.postcode()

            contact.$organization.id = orgs.randomElement()!.id!

            return account.$contacts.create(contact, on:database).transform(to: contact)
        }.flatten(on: database.eventLoop)
    }
}
