//
//  ImageCCell.swift
//  imageViewer
//
//  Created by Ismajl Marevci on 12/13/22.
//

import UIKit
import Kingfisher

class ImageCCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    
    var image: Image! {
        didSet {
            setValues()
        }
    }
    
    func setValues() {
        imgView.kf.indicatorType = .activity
        imgView.kf.setImage(
            with: image.getNormalURL(),
            options: [
                .processor(DownsamplingImageProcessor(size: imgView.frame.size)),
                .scaleFactor(UIScreen.main.scale),
                .cacheOriginalImage
            ])
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
