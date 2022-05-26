//
//  ProfileViewController2.swift
//  Navigation
//
//  Created by Timur on 05.04.2022.
//

import Foundation
import UIKit

class ProfileViewController2: UIViewController {
    
    private let profileheaderView: UIView = {
        let pfView = ProfileHeaderView()
        pfView.translatesAutoresizingMaskIntoConstraints = false
        pfView.backgroundColor = .green
        return pfView
    }()
    
    private let buttonBottom: UIButton = {
        let button = UIButton()
        var b = UIButton()
        b.setTitle("Tap me", for: .normal)
        b.titleLabel?.textColor = .white
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = .systemBlue
        b.layer.cornerRadius = 4
        b.layer.shadowColor = UIColor.black.cgColor
        b.layer.shadowOffset = CGSize(width: 4, height: 4)
        b.layer.shadowOpacity = 0.7
        b.layer.shadowRadius = 4.0
        b.layer.masksToBounds = false
        b.addTarget(self, action: #selector(tapMe), for: .touchUpInside)
        return b
    }()
    
    @objc private func tapMe(sender: UIButton){
        print(#function)
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {

        self.view.backgroundColor = .lightGray
        self.navigationItem.title = "Мой профиль"
        self.view.addSubview(profileheaderView)
        self.view.addSubview(buttonBottom)
        //--
        NSLayoutConstraint.activate([
            self.profileheaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            self.profileheaderView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            self.profileheaderView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            self.profileheaderView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -220),
            // button
            self.buttonBottom.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0),
            self.buttonBottom.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            self.buttonBottom.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            self.buttonBottom.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
