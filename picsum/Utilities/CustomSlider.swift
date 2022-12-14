//
//  CustomSlider.swift
//  imageViewer
//
//  Created by Ismajl Marevci on 12/14/22.
//

import Foundation
import UIKit

//MARK: - Costum Slider
class CustomSlider: UISlider {
    var thumbTextLabel: UILabel = UILabel()
    
    private var thumbFrame: CGRect {
        return thumbRect(forBounds: bounds, trackRect: trackRect(forBounds: bounds), value: value)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        thumbTextLabel.frame = thumbFrame
        thumbTextLabel.text = "\(Int(value))"
        thumbTextLabel.textColor = .accentColor
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addSubview(thumbTextLabel)
        thumbTextLabel.textAlignment = .center
        thumbTextLabel.font = .systemFont(ofSize: 11, weight: .semibold)
        thumbTextLabel.layer.zPosition = layer.zPosition + 1
    }
}

