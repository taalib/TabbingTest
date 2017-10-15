//
//  TabBarController.swift
//  TabbingTest
//
//  Created by Taalib Minhas on 28/09/2017.
//  Copyright © 2017 Taalib Minhas. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        if selectedViewController == nil || viewController == selectedViewController {
            return false
        }
        
        let fromView = selectedViewController!.view
        let toView = viewController.view
        
        UIView.transition(from: fromView!, to: toView!, duration: 0.3, options: [.transitionFlipFromTop], completion: nil)
        
        return true
}
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
