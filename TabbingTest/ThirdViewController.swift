//
//  ThirdViewController.swift
//  TabbingTest
//
//  Created by Taalib Minhas on 28/09/2017.
//  Copyright © 2017 Taalib Minhas. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    
    @IBOutlet var totalCount: UILabel!
    
    override func viewDidLoad() {
        totalCount.text = "\(total)"
        super.viewDidLoad()

//        self.view.backgroundColor = UIColor.init(red:1.00, green:0.37, blue:0.30, alpha:1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
