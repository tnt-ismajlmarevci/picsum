//
//  RequestREST.swift
//  imageViewer
//
//  Created by Ismajl Marevci on 12/13/22.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire

struct RequestREST {
    var baseUrl: String { return "https://picsum.photos/v2/" }
    var requestPath: String
    
    var method: HTTPMethod
    var parameters : Parameters?
    var headers : HTTPHeaders = HTTPHeaders()
    var encoding : ParameterEncoding = URLEncoding.default
    
    init(resource: String, method: HTTPMethod = .get, parameters: Parameters? = nil) {
        self.requestPath = resource.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        self.method = method
        
        headers["Accept"] = "application/json"
        
        self.parameters = parameters
        
        if method == .post || method == .put || method == .patch {
            encoding = JSONEncoding.default
        }
    }
    
    func getURL() -> URL {
        return URL(string: baseUrl.appending(self.requestPath))!
    }
    
    var description: String {
        return method.rawValue + ": " + getURL().absoluteString
    }
}
