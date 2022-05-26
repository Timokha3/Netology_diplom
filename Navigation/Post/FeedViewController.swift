//
//  FeedViewController.swift
//  Navigation
//
//  Created by Timur on 05.04.2022.
//

import Foundation
import UIKit

class FeedViewController: UIViewController {
    
    private let stackViewVertical: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.backgroundColor = .green
        sv.axis = .vertical
        sv.distribution = .fill
        sv.alignment = .center
        sv.spacing = 10
        sv.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        sv.isLayoutMarginsRelativeArrangement = true
        return sv
    }()
    
    private let btn1: UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 250, height: 60))
        //btn.center = view.center
        btn.setTitle("Открыть новость 1", for: .normal)
        btn.backgroundColor = .black
        btn.addTarget(self, action: #selector(btnTap), for: .touchUpInside)
        return btn
    }()
    
    private let btn2: UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 250, height: 60))
        //btn.center = view.center
        btn.setTitle("Открыть новость 2", for: .normal)
        btn.backgroundColor = .black
        btn.addTarget(self, action: #selector(btnTap), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .brown
        self.navigationItem.title = "Лента новостей"
        setup()
    }
    
    private func setup() {
        view.addSubview(stackViewVertical)
        stackViewVertical.addArrangedSubview(btn1)
        stackViewVertical.addArrangedSubview(btn2)
        
        NSLayoutConstraint.activate([
            self.stackViewVertical.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.stackViewVertical.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func btnTap() {
        let postVC = PostViewController()
        postVC.setup(post: Post.makeMockModel().first!)
        navigationController?.pushViewController(postVC, animated: true)
    }
}
