//
//  ViewController.swift
//  TestSQLite
//
//  Created by Тимофей Забалуев on 10/03/2019.
//  Copyright © 2019 Тимофей Забалуев. All rights reserved.
//

import UIKit
import SQLite
import SQLite3

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataBase.shared.creteTable()
        DataBase.shared.insert()
        DataBase.shared.getEntities()
        DataBase.shared.quaryAll()
        
    }

}

