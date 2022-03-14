//
//  RealmDatabase.swift
//  SalesUpApp
//
//  Created by ritech on 14.3.22.
//

import Foundation
import RealmSwift

class RealmDatabase: Database {

    private let realmThread = DispatchQueue(label: "ios.realmThread")

    static let shared = RealmDatabase()
    private init() {}


    func loadObjects<Model: Object, Query: NSPredicate>(ofType type: Model.Type, matchingQuery query: Query, completion: @escaping (Result<[Model], SalesUpError>) -> Void) {
        realmThread.async {
            autoreleasepool {
                do {
                    let realm = try Realm()
                    let objects = realm.objects(type).filter(query)
                    completion(.success(objects.toArray()))
                } catch let error {
                    print("RealmDatabase load failed: \(error)")
                    completion(.failure(.database))
                }
            }
        }
    }

    func saveObjects<Model: Object>(_ objects: [Model], completion: @escaping (SalesUpError?) -> Void) {
        realmThread.async {
            autoreleasepool {
                do {
                    let realm = try Realm()
                    try realm.write {
                        realm.add(objects, update: .modified)
                    }
                    completion(nil)
                } catch let error as NSError {
                    print("RealmDatabase save failed: \(error)")

                    if error.code == 2 {
                        completion(.databaseLoadFailure)
                    } else {
                        completion(.database)
                    }
                }
            }
        }
    }

    func deleteObjects<Model: Object>(_ objects: [Model], completion: @escaping (SalesUpError?) -> Void) {
        let objectRefs = objects.compactMap { ThreadSafeReference(to: $0) }

        realmThread.async {
            autoreleasepool {
                do {
                    let realm = try Realm()
                    let resolvedObjects = objectRefs.compactMap { realm.resolve($0) }

                    try realm.write {
                        realm.delete(resolvedObjects)
                    }
                    completion(nil)
                } catch let error {
                    print("RealmDatabase delete failed: \(error)")
                    completion(.database)
                }
            }
        }
    }

    func deleteAllObjects<Model: Object>(ofType type: Model.Type, completion: @escaping (SalesUpError?) -> Void) {
        realmThread.async {
            autoreleasepool {
                do {
                    let realm = try Realm()
                    let objects = realm.objects(type)

                    try realm.write {
                        realm.delete(objects)
                    }

                    completion(nil)
                } catch let error {
                    print("RealmDatabase delete all of type \(type) failed: \(error)")
                    completion(.database)
                }
            }
        }
    }
}

private extension Results {

    func toArray<T>() -> [T] {
        return self.compactMap { $0 as? T }
    }
}
