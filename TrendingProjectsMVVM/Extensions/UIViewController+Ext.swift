//
//  UIViewController+Ext.swift
//  TrendingProjectsMVVM
//
//  Created by Marina Huber on 9/20/20.
//  Copyright © 2020 Marina Huber. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
