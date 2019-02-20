import Vapor

struct SendMailRequest: Content, Reflectable {
    
    let email: String
    let subject: String
    let text: String
    let html: String?
}

extension SendMailRequest: Validatable {
    
    static func validations() throws -> Validations<SendMailRequest> {
        var validations = Validations(SendMailRequest.self)
        try validations.add(\.email, .email)
        return validations
    }
}
