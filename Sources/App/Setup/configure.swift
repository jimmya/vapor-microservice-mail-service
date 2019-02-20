import Vapor
import ServiceExt
import Mailgun

public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    
    Environment.dotenv()
    
    services.register { container -> NIOServerConfig in
        switch container.environment {
        case .production: return .default()
        default: return .default(port: 8084)
        }
    }
    
    services.register(Router.self) { container -> EngineRouter in
        let router = EngineRouter.default()
        try routes(router, container)
        return router
    }
    
    /// Register middlewares
    var middlewaresConfig = MiddlewareConfig()
    try middlewares(config: &middlewaresConfig)
    services.register(middlewaresConfig)
    
    guard let mailgunApiKey: String = Environment.get("MAILGUN_API_KEY"),
        let maigunDomain: String = Environment.get("MAILGUN_DOMAIN") else {
        throw Abort(.internalServerError)
    }
    let mailgun = Mailgun(apiKey: mailgunApiKey, domain: maigunDomain)
    services.register(mailgun, as: Mailgun.self)
}
