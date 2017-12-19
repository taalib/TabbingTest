//
//  ModalDesign.swift
//  TabbingTest
//
//  Created by Taalib Minhas on 22/10/2017.
//  Copyright © 2017 Taalib Minhas. All rights reserved.
//

import UIKit

class ModalDesign: UIView {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
}

