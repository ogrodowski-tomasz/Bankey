//
//  LoginViewController.swift
//  Bankey
//
//  Created by Tomasz Ogrodowski on 30/11/2022.
//

import UIKit

protocol LogoutDelegate: AnyObject {
    func didLogout()
}

protocol LoginViewControllerDelegate: AnyObject {
    func didLogIn()
}

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let errorMessageLabel = UILabel()
    
    weak var delegate: LoginViewControllerDelegate?
    
    var username: String? {
        return loginView.usernameTextField.text
    }
    
    var password: String? {
        return loginView.passwordTextField.text
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        style()
        layout()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        signInButton.configuration?.showsActivityIndicator = false
        loginView.usernameTextField.text = ""
        loginView.passwordTextField.text = ""
    }

}


extension LoginViewController {
    private func style() {
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8 // for indicator spacing
        signInButton.setTitle("Sign In", for: [])
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.text = "Error failure"
        errorMessageLabel.isHidden = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Bankey"
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.text = "Your premium source for all things banking!"
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    }
    
    private func layout() {
        let labelsStack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        labelsStack.translatesAutoresizingMaskIntoConstraints = false
        labelsStack.alignment = .center
        labelsStack.axis = .vertical
        labelsStack.spacing = 10
        
        view.addSubview(loginView)
        view.addSubview(labelsStack)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
        
        NSLayoutConstraint.activate([
            labelsStack.bottomAnchor.constraint(equalTo: loginView.topAnchor, constant: -20),
            labelsStack.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: labelsStack.trailingAnchor, multiplier: 1)
        ])
        
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1)
        ])
        
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2),
            errorMessageLabel.leadingAnchor.constraint(equalTo: signInButton.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: signInButton.trailingAnchor)
        ])
        
    }
}

extension LoginViewController {
    @objc private func signInTapped() {
        errorMessageLabel.isHidden = true
        login()
    }
    
    private func login() {
        guard let username = username, let password = password else {
            assertionFailure("Username/Password shouldn't be empty")
            return
        }
        
        if username.isEmpty || password.isEmpty {
        configureView(withMessage: "Username/Password cannot be blank!")
            return
        }
        
        if username == "Tomek" && password == "password" {
            signInButton.configuration?.showsActivityIndicator = true
            delegate?.didLogIn()
        } else {
            signInButton.configuration?.showsActivityIndicator = false
            configureView(withMessage: "Incorrect username / password")
        }
    }
    
    private func configureView(withMessage message: String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
    }
}
