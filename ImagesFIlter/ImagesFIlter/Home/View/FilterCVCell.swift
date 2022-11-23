//
//  FilterCVCell.swift
//  ImagesFIlter
//
//  Created by Ahmed Abuelmagd on 23/11/2022.
//

import UIKit

class FilterCVCell: UICollectionViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var filterImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    var centerVector: CIVector!
    
    var editingImage: UIImage!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}

extension FilterCVCell{
    //TODO:- Improve by creating filter handler
    
    func initCell(cellData: FilterModel, orignalImage: UIImage){
        titleLbl.text = cellData.title
        filterImg.image = orignalImage
        mainView.addBorder(borderColor: (cellData.isSelected) ? .MainColor : .CF6F7F8, borderWidth: 2)
        mainView.addRadius(radius: 5)
        
        
        let openGLContext = EAGLContext(api: .openGLES2)
        let context = CIContext(eaglContext: openGLContext!)
        let filter = CIFilter(name: cellData.name)
        let coreImage = CIImage(image: orignalImage)
        filter!.setDefaults()
        filter!.setValue(coreImage, forKey: kCIInputImageKey)
        let filteredImageData = filter!.value(forKey: kCIOutputImageKey) as! CIImage
        let filteredImageRef = context.createCGImage(filteredImageData, from: filteredImageData.extent)
        let imageForButton = UIImage(cgImage: filteredImageRef!)
        mainQueue {
            self.filterImg.image = imageForButton
        }
    }
}
