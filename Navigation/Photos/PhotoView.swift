//
//  PhotoView.swift
//  Navigation
//
//  Created by Timur on 20.05.2022.
//

import UIKit

class PhotoView: UIView {

    private lazy var avatarImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "avatar")
        img.backgroundColor = .clear
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        img.layer.opacity = 1
        return img
    }()
    
    private lazy var buttonClose: UIButton = {
        var b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setImage(UIImage(systemName: "multiply.circle.fill"), for: .normal)
        b.layer.masksToBounds = false
        b.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return b
    }()
    
    @objc private func buttonAction() {
        UIView.animate(withDuration: 1) {
            self.removeFromSuperview()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.addSubview(avatarImage)
        self.addSubview(buttonClose)
        
        NSLayoutConstraint.activate([
            // avatar
            self.avatarImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0),
            self.avatarImage.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            self.avatarImage.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            self.avatarImage.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            //button
            self.buttonClose.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            self.buttonClose.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            self.buttonClose.heightAnchor.constraint(equalToConstant: 40),
            self.buttonClose.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setImage(_ imageName: String) {
        avatarImage.image = UIImage(named: imageName)
    }
}
