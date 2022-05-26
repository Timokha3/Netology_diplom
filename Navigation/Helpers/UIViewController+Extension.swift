//
//  UIViewController+Extension.swift
//  Navigation
//
//  Created by Timur on 15.05.2022.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(title: String, mesg: String, handler: @escaping (UIAlertAction) -> Void){
        let alert = UIAlertController(title: title, message: mesg, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ок", style: .default, handler: handler)
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
}
