//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Timur on 19.04.2022.
//

import Foundation
import UIKit

class ProfileHeaderView: UIView, UITextFieldDelegate {
    private var statusText: String = ""
    
    private lazy var avatarImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "avatar")
        img.layer.cornerRadius = 50
        img.clipsToBounds = true
        img.layer.borderWidth = 3.0
        img.layer.borderColor = UIColor.white.cgColor
        return img
    }()
    
    private lazy var button: UIButton = {
        var b = UIButton()
        b.setTitle("Show status", for: .normal)
        b.titleLabel?.textColor = .white
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = .systemBlue
        b.layer.cornerRadius = 4
        b.layer.shadowColor = UIColor.black.cgColor
        b.layer.shadowOffset = CGSize(width: 4, height: 4)
        b.layer.shadowOpacity = 0.7
        b.layer.shadowRadius = 4.0
        b.layer.masksToBounds = false
        b.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return b
    }()
    
    private lazy var statusTextField: UITextField = {
        let ltf = UITextField()
        ltf.backgroundColor = .white
        ltf.textColor = .black
        ltf.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        ltf.autocapitalizationType = .none
        ltf.translatesAutoresizingMaskIntoConstraints = false
        ltf.layer.borderColor = UIColor.black.cgColor
        ltf.layer.borderWidth = 1
        ltf.layer.cornerRadius = 12
        ltf.placeholder = ""
        ltf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: ltf.frame.height))
        ltf.leftViewMode = .always
        return ltf
    }()
    
    
    @objc func buttonAction() {
        print(#function)
        if isEmptyTextField(statusTextField) {
            statusTextField.shake(times: 3, delta: 5)
        } else {
            self.infoLabel.text = statusText
        }
    }
    
    @objc private func statusTextChanged(_ textField: UITextField){
        print(#function)
        guard let text = textField.text else { return }
        statusText = text
    }
    
    private lazy var nameLabel: UILabel = {
        var l = UILabel()
        l.text = "Hipster Cat"
        l.textAlignment = .left
        l.textColor = .black
        l.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var infoLabel: UILabel = {
        var l = UILabel()
        l.text = "Waiting for something..."
        l.textAlignment = .left
        l.textColor = .gray
        l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    func isEmptyTextField(_ textField: UITextField) -> Bool {
        let result = true
        guard let text = textField.text else { return false }
        if text.count > 0 { return false }
        return result
    }
    
    init() {
        super.init(frame: .zero)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        let inset: CGFloat = 16
        statusTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        
        [avatarImage, nameLabel, infoLabel, statusTextField, button].forEach {
            self.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            // avatar
            self.avatarImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: inset),
            self.avatarImage.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: inset),
            self.avatarImage.widthAnchor.constraint(equalToConstant: 100),
            self.avatarImage.heightAnchor.constraint(equalToConstant: 100),
            // name
            self.nameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 27),
            self.nameLabel.leadingAnchor.constraint(equalTo: self.avatarImage.trailingAnchor, constant: inset),
            self.nameLabel.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: 0),
            // info
            self.infoLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 16),
            self.infoLabel.leadingAnchor.constraint(equalTo: self.avatarImage.trailingAnchor, constant: inset),
            self.infoLabel.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: 0),
            self.infoLabel.bottomAnchor.constraint(equalTo: self.statusTextField.topAnchor, constant: -inset),
            //textField
            self.statusTextField.topAnchor.constraint(equalTo: self.infoLabel.bottomAnchor, constant: 8),
            self.statusTextField.leadingAnchor.constraint(equalTo: self.avatarImage.trailingAnchor, constant: inset),
            self.statusTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            self.statusTextField.heightAnchor.constraint(equalToConstant: 40),
            
            //button
            self.button.topAnchor.constraint(equalTo: self.statusTextField.bottomAnchor, constant: 8),
            self.button.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: inset),
            self.button.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            self.button.heightAnchor.constraint(equalToConstant: 50),
            
            self.bottomAnchor.constraint(equalTo: self.button.bottomAnchor, constant: inset)
            
        ])
    }
}
