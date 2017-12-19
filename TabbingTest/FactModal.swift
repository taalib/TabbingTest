//
//  FactModal.swift
//  TabbingTest
//
//  Created by Taalib Minhas on 22/10/2017.
//  Copyright © 2017 Taalib Minhas. All rights reserved.
//

import UIKit

class FactModal: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func dismissModal(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
