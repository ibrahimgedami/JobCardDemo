
protocol AuthRepoProtocol: AnyObject {

    func login(body:LoginViewModel, handler: @escaping (AppResponse<AuthModel>) -> Void)
    
}

class AuthRepo {
    
    private let network: NetworkProtocol
    
    init(network: NetworkProtocol) {
        self.network = network
    }
}

extension AuthRepo: AuthRepoProtocol {
   
    func login(body: LoginViewModel, handler: @escaping (AppResponse<AuthModel>) -> Void) {
        network.request(AuthRouter.login(body: body), decodeTo: AuthModel.self, completionHandler: handler)
    }

}
