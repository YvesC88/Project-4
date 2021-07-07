//
//  QuadrupleFrameView.swift
//  P4_01_Xcode
//
//  Created by Yves Charpentier on 05/07/2021.
//

import Foundation
import UIKit

class QuadrupleFrameView: UIView, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var contentView: UIView!
    
    @IBOutlet var topLeftImageView: UIImageView!
    @IBOutlet var topRightImageView: UIImageView!
    @IBOutlet var bottomLeftImageView: UIImageView!
    @IBOutlet var bottomRightImageView: UIImageView!
    
    var imageViewToFill: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        topLeftImageView?.backgroundColor = .white
        topRightImageView?.backgroundColor = .white
        bottomLeftImageView?.backgroundColor = .white
        bottomRightImageView?.backgroundColor = .white
    }

    func setup(with model: QuadrupleFrame) {
        topLeftImageView!.image = model.topLeftImage
        topRightImageView!.image = model.topRightImage
        bottomLeftImageView!.image = model.bottomLeftImage
        bottomRightImageView!.image = model.bottomRightImage
    }
}
