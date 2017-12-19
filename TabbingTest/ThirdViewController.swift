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
    @IBOutlet var myTableView: UITableView!
    
    override func viewDidLoad() {
        totalCount.text = "\(total)"
        super.viewDidLoad()
        myTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return birdData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        
        cell.textLabel?.text = birdData[indexPath.row]
        
        return cell
        
    }
    
    

}
