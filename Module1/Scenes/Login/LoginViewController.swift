//
//  LoginViewController.swift
//  Module1
//
//  Created by Adam Bella on 2022. 02. 27..
//

import UIKit

protocol LoginViewInterface: AnyObject {
    func present(errorMessage: String)
}

final class LoginViewController: UIViewController {
    // MARK: - Outlets

    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!

    // MARK: - Public properties

    var viewModel: LoginViewModelInterface?

    // MARK: - Lifecycle functions

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUICompontents()
    }
}

// MARK: - LoginViewInterface

extension LoginViewController: LoginViewInterface {
    func present(errorMessage: String) {
        let errorAlert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        DispatchQueue.main.async {
            self.present(errorAlert, animated: true, completion: nil)
        }
    }
}

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case usernameTextField:
            passwordTextField.becomeFirstResponder()
        default:
            passwordTextField.resignFirstResponder()
            viewModel?.login(username: usernameTextField.text, password: passwordTextField.text)
        }
        return true
    }
}

private extension LoginViewController {
    func setupUICompontents() {
        usernameTextField.becomeFirstResponder()
    }
}
