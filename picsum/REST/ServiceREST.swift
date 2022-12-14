//
//  RestAPI.swift
//  imageViewer
//
//  Created by Ismajl Marevci on 12/13/22.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire


struct ServiceREST {
    @discardableResult static func request(with rest: RequestREST, completion: @escaping ((ResponseREST) -> Void)) -> DataRequest {
        
        return AF.request(rest.getURL(), method: rest.method, parameters: rest.parameters, encoding: rest.encoding, headers: rest.headers)
            .responseData { (responseObject) in
                let responseREST: ResponseREST = ResponseREST(requestREST: rest, responseData: responseObject.value, responseHttp: responseObject.response, error: responseObject.error)
                completion(responseREST)
            }
    }
}
