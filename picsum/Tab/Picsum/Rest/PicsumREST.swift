//
//  PicsumREST.swift
//  imageViewer
//
//  Created by Ismajl Marevci on 12/13/22.
//

import SwiftyJSON
import Alamofire

class PicsumREST {
    static func getImages(page: Int = 1, limit: Int = 30, completion: @escaping ((Images?, Pagination?, PCError?)-> Void)) {
        let request = RequestREST(resource: "list/?page=\(page)&limit=\(limit)/200/200")
        
        ServiceREST.request(with: request) { response in
            guard let jsonItems = response.json.array else {
                completion(nil, nil, response.pcError())
                return
            }
            var images: Images = []
                
            for jsonItem in jsonItems {
                if let image = Image.create(from: jsonItem) {
                    images.append(image)
                }
            }
            if let pagination = Pagination.create(from: response.responseHttp?.headers.first(where: {$0.name.lowercased() == "link"})?.value ?? "") {
                completion(images, pagination, nil)
            }
            completion(images, nil, nil)
        }
    }
}
