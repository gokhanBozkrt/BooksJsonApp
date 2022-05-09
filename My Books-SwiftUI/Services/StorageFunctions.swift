//
//  StorageFunctions.swift
//  CTHelpSPMMaster
//
//  Created by Stewart Lynch on 2019-06-28.
//  Copyright © 2019 CreaTECH Solutions. All rights reserved.
//

import Foundation

class StorageFunctions {
    static let backupUrl = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("backup.json")
    static let bundleUrl = Bundle.main.url(forResource: "Seed", withExtension: "json")!
   
    static func retrieveBooks() -> [BookItem] {
      var url = backupUrl
        if !FileManager().fileExists(atPath: backupUrl.path) {
            url = bundleUrl
        }
        let decoder = JSONDecoder()
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Unable to decode")
        }
        guard let bookItems = try? decoder.decode([BookItem].self, from: data) else {
            fatalError("failed decode json from data")
        }
        return bookItems
    }
    
    
    static func storeBooks(books:[BookItem]) {
        let encoder = JSONEncoder()
        guard let bookJsonData = try? encoder.encode(books) else {
            fatalError("couldnt encode data")
        }
        let bookJson = String(data: bookJsonData, encoding: .utf8)
        do {
            try  bookJson?.write(to: backupUrl, atomically: true, encoding: .utf8)
        } catch {
            print("Couldnt save file to dşrectory : \(error.localizedDescription)")
        }
    }
}
