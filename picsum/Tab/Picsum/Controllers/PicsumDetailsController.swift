//
//  PicsumDetailsController.swift
//  imageViewer
//
//  Created by Ismajl Marevci on 12/13/22.
//

import UIKit

class PicsumDetailsController: UIViewController {
    
    @IBOutlet weak var imgHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var typeSegment: UISegmentedControl!
    @IBOutlet weak var blurSlider: UISlider!
    @IBOutlet weak var blurDetailsHolder: UIView!
    
    var image: Image!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setValues()
        commonUI()
    }
    
    func setValues() {
        guard let image = image else { return }
        title = image.author
        setImage(url: image.getNormalURL())
        imgHeightConstraint.constant = image.heightSizeBasedOnWidthScreen
    }
    
    func commonUI() {
        imgView.layer.borderWidth = 2
        imgView.layer.borderColor = UIColor.label.cgColor
        
        blurSlider.isContinuous = false
    }
    
    func setImage(url: URL?) {
        imgView.kf.indicatorType = .activity
        imgView.kf.setImage(with: url, options: [.transition(.fade(0.2))])
    }

    @IBAction func typeSegmentChanged(_ sender: UISegmentedControl) {
        guard let image = image else { return }
        blurDetailsHolder.isHidden = sender.selectedSegmentIndex != 0
        
        switch sender.selectedSegmentIndex {
        case 0:
            setImage(url: image.getBlurUrl(scale: Int(blurSlider.value)))
        case 1:
            setImage(url:  image.getNormalURL())
        case 2:
            setImage(url:  image.getGrayscaleURL())
        default:
            break
        }
    }
    
    @IBAction func blurSliderChanged(_ sender: UISlider) {
        let step: Float = 1
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        if roundedValue.truncatingRemainder(dividingBy: 1) == 0 {
            imgView.kf.setImage(with: image.getBlurUrl(scale: Int(roundedValue)))
        }
    }
}

extension PicsumDetailsController {
    static func create(image: Image) -> PicsumDetailsController {
        let controller = UIStoryboard(name: "Picsum", bundle: nil).instantiate(PicsumDetailsController.self)
        controller.image = image
        return controller
    }
}
