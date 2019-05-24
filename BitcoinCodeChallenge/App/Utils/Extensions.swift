//
//  Extensions.swift
//  BitcoinCodeChallenge
//
//  Created by BURAK KEBAPCI on 5/24/19.
//  Copyright © 2019 BurakKebapci. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    func presentAlert(_ title: String, message: String, color:UIColor = UIColor.red, iconName:String = "alert", duration:Double = 2.0) {
        DispatchQueue.main.async {
            let banner = Banner(title: title, subtitle: message, image: UIImage(named: iconName), backgroundColor: color)
            banner.dismissesOnTap = true
            banner.show(duration: duration)
        }
    }

    func largeTitle() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeTitleTextAttributes =
            [NSAttributedString.Key.foregroundColor:UIColor.black,
             NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 20)]
    }

    override open func awakeFromNib() {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "LogoNav"))
        self.navigationItem.titleView = imageView
        self.navigationItem.title = "Bitcoin.com Coding Challenge"
        self.navigationItem.titleView?.frame = CGRect(x: 0, y: 0, width: 30, height: 20)
        navigationController?.navigationBar.barTintColor =  UIColor.white
    }
}
