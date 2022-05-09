//
//  BookItem.swift
//  CTHelpSPMMaster
//
//  Created by Stewart Lynch on 2019-06-28.
//  Copyright © 2019 CreaTECH Solutions. All rights reserved.
//

import Foundation

struct BookItem: Codable, Identifiable {
    let id = UUID()
    var title:String
    var author:String
    var notes:String
}
