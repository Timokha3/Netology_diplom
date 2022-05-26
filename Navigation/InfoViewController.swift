//
//  InfoViewController.swift
//  Navigation
//
//  Created by Timur on 10.04.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
    }
    
    private func setup() {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 250, height: 60))
        btn.center = view.center
        btn.setTitle("Прочитано", for: .normal)
        btn.backgroundColor = .black
        btn.addTarget(self, action: #selector(btnTap), for: .touchUpInside)
        view.addSubview(btn)
    }
    
    @objc func btnTap() {
        let infoAlert = UIAlertController(title: "Внимание", message: "Вы точно хотите отметить новость как прочитанной?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Да", style: .default) { _ in
            print("Новость прочитана!")
            self.dismiss(animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive) { _ in
            print("Статус новости не изменился!")
        }
        
        infoAlert.addAction(cancelAction)
        infoAlert.addAction(okAction)
        present(infoAlert, animated: true)
    }
    
}
