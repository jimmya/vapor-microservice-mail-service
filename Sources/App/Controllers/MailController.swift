import Vapor
import Mailgun

struct MailController: RouteCollection {
    
    func boot(router: Router) throws {
        let mailRouter = router.grouped("mail")
        
        mailRouter.post(SendMailRequest.self, at: "", use: send)
    }
}

private extension MailController {
    
    func send(_ req: Request, sendRequest: SendMailRequest) throws -> Future<HTTPStatus> {
        guard let sender: String = Environment.get("SENDER") else {
            throw Abort(.internalServerError)
        }
        
        let message = Mailgun.Message(
            from: sender,
            to: sendRequest.email,
            subject: sendRequest.subject,
            text: sendRequest.text,
            html: sendRequest.html
        )
        
        let mailgun = try req.make(Mailgun.self)
        return try mailgun.send(message, on: req).transform(to: .ok)
    }
}
