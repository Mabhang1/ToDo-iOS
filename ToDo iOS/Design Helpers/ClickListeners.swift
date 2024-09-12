//
//  ClickListeners.swift
//  DMS
//
//  Created by Abhang Mane @Goldmedal on 27/06/24.
//  Copyright © 2024 Goldmedal. All rights reserved.
//

import UIKit
// MARK: ClickListener
class ClickListener: UITapGestureRecognizer {
    var onClick : (() -> Void)? = nil
}


// MARK: UIView Extension
extension UIView {
    
    func setOnClickListener(action :@escaping () -> Void){
        let tapRecogniser = ClickListener(target: self, action: #selector(onViewClicked(sender:)))
        tapRecogniser.onClick = action
        self.addGestureRecognizer(tapRecogniser)
    }
    
    @objc func onViewClicked(sender: ClickListener) {
        if let onClick = sender.onClick {
            onClick()
        }
    }
  
}
