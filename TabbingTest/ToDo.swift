//
//  ToDo.swift
//  TabbingTest
//
//  Created by Taalib Minhas on 30/09/2017.
//  Copyright © 2017 Taalib Minhas. All rights reserved.
//

import UIKit
import os.log

class ToDo: NSObject, NSCoding {
    
    init(name: String) {
        self.name = name
        super.init()
    }
    
    var name: String
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("toDo")
    
    //MARK: Type
    struct PropertyKey {
        
        static let name = "name"
        
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let toDo = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for List object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Must call designated initializer.
        self.init(name: toDo)
    }
    
}
