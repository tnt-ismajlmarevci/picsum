//
//  ResponseREST.swift
//  imageViewer
//
//  Created by Ismajl Marevci on 12/13/22.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire

typealias ErrorMessage = String

struct ResponseREST {
    var requestREST: RequestREST
    var responseData: Any?
    var responseHttp : HTTPURLResponse?
    var error: Error?
    
    /// get status code from http request, if no status code 0
    var statusCode : Int {
        if let statusCode = responseHttp?.statusCode {
            return statusCode
        }
        return 0
    }
    
    /// get json data from http response, if no data JSON.null is return
    var json: JSON {
        if let data = responseData {
            return JSON(data)
        }
        return JSON.null
    }

    func pcError(message: String = "Sorry, something went wrong.") -> PCError{
        return PCError(message: message, code: responseHttp?.statusCode ?? 0)
    }
}

//MARK - Extension DataResponse
extension DataResponse {
    var json : JSON {
        return JSON.null
    }
    
    var isSuccess: Bool {
        if let response = self.response?.statusCode {
            return response >= 200 && response <= 299
        }
        
        return false
    }
    
    var isBad: Bool {
        if let response = self.response?.statusCode {
            return response == 400
        }
        
        return false
    }
    
    var isError: Bool {
        return self.error != nil
    }
    
    var isUnAuthorized: Bool {
        if let response = self.response?.statusCode {
            return response == 401
        }
        
        return false
    }
    
    var isForbidden: Bool {
        if let response = self.response?.statusCode {
            return response == 403
        }
        return false
    }
    
    var errorMessage : String? {
        if let error = self.error?.localizedDescription {
            return error
        }
        
        if let message = json["detail"].string {
            return message
        }
        
        return nil
    }
}


struct PCError {
    var message: ErrorMessage
    var code : Int
}
