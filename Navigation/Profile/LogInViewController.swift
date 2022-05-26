//
//  LogInViewController.swift
//  Navigation
//
//  Created by Timur on 28.04.2022.
//

import Foundation
import UIKit

class LogInViewController: UIViewController, UITextFieldDelegate {
    static let email = "1@mail.ru"
    static let password = "111111"
    static let minPasswordLength = 6
    
    let notificationCenter = NotificationCenter.default
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
        return $0
    }(UIView())
    
    private let logoImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "logo.png")
        return img
    }()
    
    private let stackViewTextFieldVertical: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.backgroundColor = .clear
        sv.axis = .vertical
        sv.distribution = .fillProportionally
        return sv
    }()
    
    private lazy var loginTextField: UITextField = {
        let ltf = UITextField()
        ltf.delegate = self
        ltf.backgroundColor = .systemGray6
        ltf.textColor = .black
        ltf.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        //ltf.tintColor =
        ltf.autocapitalizationType = .none
        ltf.translatesAutoresizingMaskIntoConstraints = false
        ltf.layer.borderColor = UIColor.lightGray.cgColor
        ltf.layer.borderWidth = 0.5
        ltf.layer.cornerRadius = 10
        ltf.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        ltf.placeholder = "Email or phone"
        ltf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: ltf.frame.height))
        ltf.leftViewMode = .always
        return ltf
    }()
    
    private lazy var passwordTextField: UITextField = {
        let ltf = UITextField()
        ltf.delegate = self
        ltf.backgroundColor = .systemGray6
        ltf.textColor = .black
        ltf.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        //ltf.tintColor =
        ltf.isSecureTextEntry = true
        ltf.autocapitalizationType = .none
        ltf.translatesAutoresizingMaskIntoConstraints = false
        ltf.layer.borderColor = UIColor.lightGray.cgColor
        ltf.layer.borderWidth = 0.5
        ltf.layer.cornerRadius = 10
        ltf.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        ltf.placeholder = "Password"
        ltf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: ltf.frame.height))
        ltf.leftViewMode = .always
        return ltf
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.text = ""
        return label
    }()
    
    private let logInBottom: UIButton = {
        var b = UIButton()
        b.setTitle("Log In", for: .normal)
        b.titleLabel?.textColor = .white
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = UIColor(named: "ColorVK")
        b.layer.cornerRadius = 10
        b.addTarget(self, action: #selector(auth), for: .touchUpInside)
        return b
    }()
    
    @objc private func auth(sender: UIButton){
        if validData() {
            let profileVC = ProfileViewController()
            navigationController?.pushViewController(profileVC, animated: true)
        }
    }
    
    @objc private func inputDataTFAction() {
        errorLabel.text = ""
        guard let text = passwordTextField.text else { return }
        if text.count < 6 {
            errorLabel.text = "Минимальная длина пароля 6 символов"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        layout()
        //loginTextField.text = "1@mail.ru"
        //passwordTextField.text = "111111"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notificationCenter.addObserver(self, selector: #selector(keybordShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keybordHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func configure() {
        self.view.backgroundColor = .white
        self.hideKeyboardWhenTappedAround()
        self.navigationController?.isNavigationBarHidden = true
        passwordTextField.addTarget(self, action: #selector(inputDataTFAction), for: .editingChanged)
    }
    
    private func layout() {
        let inset: CGFloat = 16
        view.addSubview(scrollView)
        
        [loginTextField, passwordTextField].forEach { stackViewTextFieldVertical.addArrangedSubview($0)}
        [logoImage, stackViewTextFieldVertical, logInBottom, errorLabel].forEach { contentView.addSubview($0) }
        
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            //scroll
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            //content
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            //logo
            logoImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            logoImage.widthAnchor.constraint(equalToConstant: 100),
            logoImage.heightAnchor.constraint(equalToConstant: 100),
            
            //stack
            stackViewTextFieldVertical.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 120),
            stackViewTextFieldVertical.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            stackViewTextFieldVertical.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            stackViewTextFieldVertical.heightAnchor.constraint(equalToConstant: 100),
            
            // button
            logInBottom.heightAnchor.constraint(equalToConstant: 50),
            logInBottom.topAnchor.constraint(equalTo: stackViewTextFieldVertical.bottomAnchor, constant: inset + 8),
            logInBottom.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            logInBottom.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            logInBottom.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
            
            //errorLabel
            errorLabel.topAnchor.constraint(equalTo: stackViewTextFieldVertical.bottomAnchor, constant: 1),
            errorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            errorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset + 16)
        ])
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
// MARK: -
extension LogInViewController {
    func validData() -> Bool {
        let result = false
        if isEmptyTextField(loginTextField) {
            loginTextField.shake(times: 3, delta: 5)
            return result
        }
        if isEmptyTextField(passwordTextField)  {
            passwordTextField.shake(times: 3, delta: 5)
            return result
        }
        if let text = loginTextField.text, !isValidEmail(text) {
            self.showAlert(title: "Ошибка", mesg: "Не верный формат Email адреса") { _ in
                self.loginTextField.shake(times: 3, delta: 5)
            }
            return result
        }
        if let text = passwordTextField.text, text.count < 6 {
            passwordTextField.shake(times: 3, delta: 5)
            return result
        }
        return true
    }
    func isEmptyTextField(_ textField: UITextField) -> Bool {
        let result = true
        guard let text = textField.text else { return false }
        if text.count > 0 { return false }
        return result
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

// MARK: - Keybord Events
extension LogInViewController {
    @objc private func keybordShow(notification: NSNotification){
        if let keybordSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = keybordSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keybordSize.height, right: 0)
        }
    }
    
    @objc private func keybordHide() {
        self.scrollView.contentInset = .zero
        self.scrollView.verticalScrollIndicatorInsets = .zero
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
