//
//  Pagination.swift
//  imageViewer
//
//  Created by Ismajl Marevci on 12/14/22.
//

import UIKit
import SwiftyJSON

class Pagination: NSObject {
    
    var nextPage: Int       = 1
    var prevPage: Int       = 1
    var currPage: Int       = 1
    var hasNextPage: Bool   = false
    var hasPrevPage: Bool   = false
    var limit: Int          = 30

    static func create(from string: String) -> Pagination? {
        let links: [String] = string.components(separatedBy: ",")
        
        guard !links.isEmpty else { return nil }
        
        let pagination = Pagination()
        
        var dictionary: [String: String] = [:]
        links.forEach({
            let components = $0.components(separatedBy:"; ")
            let cleanPath = components[0].trimmingCharacters(in: CharacterSet(charactersIn: " <>"))
            dictionary[components[1]] = cleanPath
        })
        
        if let nextPagePath = dictionary["rel=\"next\""], let nextPageString = URL(string: nextPagePath)?.valueOf("page"), let nextPage = Int(nextPageString) {
            pagination.hasNextPage = true
            pagination.nextPage = nextPage
        }
        
        if let prevPagePath = dictionary["rel=\"prev\""], let prevPageString = URL(string: prevPagePath)?.valueOf("page"), let prevPage = Int(prevPageString) {
            pagination.hasPrevPage = true
            pagination.prevPage = prevPage
        }
        
        return pagination
    }
}

//  - some : "<https://picsum.photos/v2/list?page=1&limit=30>; rel="prev", <https://picsum.photos/v2/list?page=3&limit=30>; rel="next""
