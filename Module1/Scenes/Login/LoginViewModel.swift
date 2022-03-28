//
//  LoginViewModel.swift
//  Module1
//
//  Created by Adam Bella on 2022. 02. 27..
//

protocol LoginFlowDelegate: AnyObject {
    func successfullyLoggedIn()
}

protocol LoginViewModelInterface {
    var flowDelegate: LoginFlowDelegate? { get }
    var view: LoginViewInterface? { get }

    func login(username: String?, password: String?)
}

final class LoginViewModel: LoginViewModelInterface {
    private enum Constants {
        static let mockUsername = "user"
        static let mockPassword = "123qwe"
    }

    private(set) weak var view: LoginViewInterface?
    private(set) weak var flowDelegate: LoginFlowDelegate?

    init(view: LoginViewInterface, flowDelegate: LoginFlowDelegate) {
        self.view = view
        self.flowDelegate = flowDelegate
    }

    final func login(username: String?, password: String?) {
        guard let loginData = LoginData(username: username, password: password) else {
            callInvalidCredentialsError()
            return
        }
        login(using: loginData)
    }
}

private extension LoginViewModel {
    func login(using data: LoginData) {
        guard data.username.caseInsensitiveCompare(Constants.mockUsername) == .orderedSame,
              data.password == Constants.mockPassword else {
                  callInvalidCredentialsError()
            return
        }
        flowDelegate?.successfullyLoggedIn()
    }

    func callInvalidCredentialsError() {
        view?.present(errorMessage: "Invalid credentials")
    }
}
