//
//  JSONWordCollections.swift
//  JSONWordCollections
//
//  Created by Charles Diggins on 1/11/22.
//

import Foundation
import UIKit

struct JsonWordCollectionManager: Codable {
    var collectionList: [JSONWordCollection]
    struct WordCollection: Codable {
        var collectionName: String?  //if named, then this is a phrase
    }
    
}
