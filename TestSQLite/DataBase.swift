//
//  DataBase.swift
//  TestSQLite
//
//  Created by Тимофей Забалуев on 11/03/2019.
//  Copyright © 2019 Тимофей Забалуев. All rights reserved.
//

import SQLite
import SQLite3

class DataBase{
    
    static let shared = DataBase()
    public let connection: Connection?
    let dbPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first as String!
    
    let databaseFileName = "TestSQLite.sql"
    let users = Table("users10")
    let id = Expression<Int64>("id")
    let name = Expression<String?>("name")
    let email = Expression<String>("email")
    
    init() {
        do {
            connection = try Connection("\(dbPath!)/(databaseFileName)")
            print("connection created")
        }
        catch{
            connection = nil
            let nserror = error as Error
            print(nserror)
        }
    }
    
    func creteTable() {
        do {
//            try connection?.run(users.create { table in
//                table.column(id, primaryKey: true)
//                table.column(name)
//                table.column(email, unique: true)
//            })
            
            try connection?.run(users.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (table) in
                    table.column(id, primaryKey: true)
                    table.column(name)
                    table.column(email, unique: true)
            }))
            print("table succsesfuly created or exist")
        }
        catch{
            let nserror = error as Error
            print(nserror)
        }
    }
    
    func insert() {
        let insert = users.insert(name <- "Alicezz", email <- "alice@maczz.com")
        do {
            try connection?.run(insert)
            print("enity inserted")
        } catch {
            let nserror = error as Error
            print(nserror)
        }
    }
    
    func getEntities() {
        do {
            let connection = try Connection("\(dbPath!)/(databaseFileName)")
            let result = try connection.prepare(users)
            for us in result {
                print(us[name]!)
                print(us[email])
            }
        } catch {
            let nserror = error as Error
            print(nserror)
        }
    }
    
    func quaryAll() -> AnySequence<Row>? {
        do{
            return try connection?.prepare(self.users)
        }
        catch{
            let nserror = error as Error
            print(nserror)
            return nil
        }
    }
}
