//
//  Image.swift
//  imageViewer
//
//  Created by Ismajl Marevci on 12/13/22.
//

import Foundation
import SwiftyJSON
import Alamofire
import UIKit

typealias Images = [Image]

class Image {
    var id:             String = ""
    var author:         String = ""
    var width:          Int = 0
    var height:         Int = 0
    var url:            String = ""
    var downloadUrl:    String = ""

    static func create(from json: JSON) -> Image? {
        guard let id = json["id"].string else { return nil }
        
        let image           = Image()
        image.id            = id
        image.author        = json["author"].string ?? ""
        image.width         = json["width"].int ?? 0
        image.height        = json["height"].int ?? 0
        image.url           = json["url"].string ?? ""
        image.downloadUrl   = json["download_url"].string ?? ""
        return image
    }
    
    var grayscaleUrl: String {
        return downloadUrl + "?grayscale"
    }
    
    func blurUrl(scale: Int = 1) -> String {
        return downloadUrl + "?blur=\(scale)"
    }
    
    func getNormalURL() -> URL? {
        guard !downloadUrl.isEmpty else { return nil }
        return URL(string: downloadUrl)
    }
    
    func getGrayscaleURL() -> URL? {
        guard !grayscaleUrl.isEmpty else { return nil }
        return URL(string: grayscaleUrl)
    }
    func getBlurUrl(scale: Int = 1) -> URL? {
        guard !blurUrl().isEmpty else { return nil }
        return URL(string: blurUrl(scale: scale))
    }
    
    var heightSizeBasedOnWidthScreen : CGFloat {
        let screen = UIScreen.main.bounds.width - 32 // 32 for padding
        let ratio: CGFloat = CGFloat(height) / CGFloat(width)
        return screen * ratio
    }
}

//[
//    {
//        "id": "0",
//        "author": "Alejandro Escamilla",
//        "width": 5616,
//        "height": 3744,
//        "url": "https://unsplash.com/...",
//        "download_url": "https://picsum.photos/..."
//    },
//    {}
//]
