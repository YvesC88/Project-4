//
//  TripleLeftFrameView.swift
//  P4_01_Xcode
//
//  Created by Yves Charpentier on 06/07/2021.
//

import Foundation
import UIKit

class TripleLeftFrameView: UIView, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet var topImageView: UIImageView!
    @IBOutlet var bottomLeftImageView: UIImageView!
    @IBOutlet var bottomRightImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(with model: TripleLeftFrame) {
        topImageView.image = model.topImage
        bottomLeftImageView.image = model.bottomLeftImage
        bottomRightImageView.image = model.bottomRightImage
    }
}
