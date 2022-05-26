//
//  PostViewController.swift
//  Navigation
//
//  Created by Timur on 05.04.2022.
//

import Foundation
import UIKit

class PostViewController: UIViewController {
    
    private let stackViewVertical: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.backgroundColor = .clear
        sv.axis = .horizontal
        sv.distribution = .fill
        sv.alignment = .top
        sv.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        sv.isLayoutMarginsRelativeArrangement = true
        return sv
    }()
    
    private lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var postLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .systemGray3
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.text = ""
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        configure()
    }
    
    private func configure() {
        let barBtn = UIBarButtonItem(image: UIImage(systemName: "info.circle.fill"), style: .plain, target: self, action: #selector(barBtnTap))
        navigationItem.rightBarButtonItem = barBtn
        
        stackViewVertical.addArrangedSubview(postLabel)
        let inset: CGFloat = 16
        view.addSubview(postImageView)
        view.addSubview(stackViewVertical)
        
        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            postImageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            postImageView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            postImageView.heightAnchor.constraint(equalTo: self.view.widthAnchor),
            
            stackViewVertical.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: inset),
            stackViewVertical.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inset),
            stackViewVertical.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -inset),
            stackViewVertical.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -inset),
            postLabel.topAnchor.constraint(equalTo: stackViewVertical.topAnchor, constant: 0)
        ])
    }
    
    func setup(post: Post) {
        navigationItem.title = post.author
        postLabel.text = post.description
        postImageView.image = UIImage(named: post.image)
    }
    
    @objc func barBtnTap() {
        let vc = InfoViewController()
        present(vc, animated: true)
    }
}
