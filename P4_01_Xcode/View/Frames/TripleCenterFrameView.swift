//
//  TripleCenterFrameView.swift
//  P4_01_Xcode
//
//  Created by Yves Charpentier on 06/07/2021.
//

import Foundation
import UIKit

class TripleCenterFrameView: UIView, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet var topLeftImageView: UIImageView!
    @IBOutlet var topRightImageView: UIImageView!
    @IBOutlet var bottomImageView: UIImageView!
}
