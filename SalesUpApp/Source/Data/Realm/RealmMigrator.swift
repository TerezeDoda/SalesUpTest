//
//  RealmMigrator.swift
//  SalesUpApp
//
//  Created by ritech on 14.3.22.
//

import Foundation
import RealmSwift

class RealmMigrator: NSObject {

    private static let realmFilename = "encrypted-storage.realm"

    class func performMigrations() {
     do {
        _ = try Realm()
            print("Realm opened successfully")
        } catch let error {
            print("error\(error)")
        }
    }
}
