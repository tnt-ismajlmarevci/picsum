//
//  PicsumViewModel.swift
//  imageViewer
//
//  Created by Ismajl Marevci on 12/13/22.
//

import Foundation
import Combine

class PicsumViewModel: ObservableObject {
 
    @Published var images: Images = []
    @Published var error: PCError? = nil
    var pagination: Pagination = Pagination()
    
    func loadImages(reset: Bool = false) {
        let page = (reset ? 1 : pagination.nextPage)
        print("NEXT PAGE \(pagination.nextPage)")
        PicsumREST.getImages(page: page, limit: pagination.limit) { [weak self] images, pagination, error in
            guard let images = images else {
                if let error = error {
                    self?.error = error
                }
                return
            }
            
            if reset { self?.images.removeAll() }
            
            if let pagination = pagination {
                pagination.currPage = page
                self?.pagination = pagination
            }
            self?.images += images
        }
    }
}
