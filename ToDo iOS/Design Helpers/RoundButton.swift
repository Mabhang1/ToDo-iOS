//
//  RoundButton.swift
//  DMS
//
//  Created by Abhang Mane @Goldmedal on 24/06/24.
//  Copyright © 2024 Goldmedal. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class RoundButton : UIButton
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
    
    @IBInspectable var shadowColor: UIColor = UIColor.clear
        {
        didSet {
            self.layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 0)
        {
        didSet {
            self.layer.shadowOffset = shadowOffset
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0
        {
        didSet {
            self.layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable var masksToBounds: Bool = false
        {
        didSet {
            self.layer.masksToBounds = masksToBounds
        }
    }
    
    @IBInspectable var shadowOpacity: CGFloat = 0
        {
        didSet {
            self.layer.shadowOpacity = Float(shadowOpacity)
        }
    }
    

    
}
