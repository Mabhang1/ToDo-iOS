//
//  RoundEditText.swift
//  DMS
//
//  Created by Abhang Mane @Goldmedal on 08/07/24.
//  Copyright © 2024 Goldmedal. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class RoundEditText : UITextField
{
    
    @IBInspectable var cornerRadius: CGFloat = 0
        {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    
    @IBInspectable var borderWidth: CGFloat = 0
        {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear
        {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }

     var rightImageShow: Bool = false {
        didSet {
            if rightImageShow == true {
                self.rightViewMode = UITextField.ViewMode.always

                let view = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.height, height: self.bounds.size.height))

                let imageView = UIImageView(frame: CGRect(x: 0, y: 10, width: self.bounds.size.height-20, height: self.bounds.size.height-20))

                let button = UIButton(frame: CGRect(x: 0, y: 10, width: self.bounds.size.height-20, height: self.bounds.size.height-20))
                button.addTarget(self, action: #selector(showText), for: .touchUpInside)
                imageView.contentMode = .scaleAspectFit
                view.addSubview(button)
                view.addSubview(imageView)
                self.rightView = view
                view.tag = 1111101
                imageView.tag = 11111012
            }

        }
    }
    
     var rightImageNamed: String = "" {
        didSet {
            if rightImageShow {
                let viewSource = self.rightView?.viewWithTag(1111101)
                let imageView = viewSource!.viewWithTag(11111012) as! UIImageView
                imageView.image = UIImage(named: rightImageNamed)

            }

        }
    }
    
    @objc func showText() {
        let viewSource = self.rightView?.viewWithTag(1111101)
        let imageView = viewSource!.viewWithTag(11111012) as! UIImageView


        if self.isSecureTextEntry {
            self.isSecureTextEntry = false
            imageView.image = UIImage(named: "eye")


        }
        else{
            self.isSecureTextEntry = true
            imageView.image = UIImage(named: "eye")

        }
    }
    
}
