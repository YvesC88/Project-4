//
//  TripleCenterFrameView.swift
//  P4_01_Xcode
//
//  Created by Yves Charpentier on 06/07/2021.
//

import Foundation
import UIKit

class TripleCenterFrameView: UIView {
    
    @IBOutlet var topLeftImageView: UIImageView!
    @IBOutlet var topRightImageView: UIImageView!
    @IBOutlet var bottomImageView: UIImageView!
    
    @IBOutlet var topLeftButton: UIButton!
    @IBOutlet var topRightButton: UIButton!
    @IBOutlet var bottomButton: UIButton!
    
    weak var delegate: ViewControllerDelegate?
    var swipeGestureRecognizer: UISwipeGestureRecognizer!
    
    //MARK: - Object lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        topLeftImageView?.backgroundColor = .clear
        topRightImageView?.backgroundColor = .clear
        bottomImageView?.backgroundColor = .clear
        
        NotificationCenter.default.addObserver(self, selector: #selector(onScreenRotated), name: UIDevice.orientationDidChangeNotification, object: nil)
        
        swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeView(_:)))
        swipeGestureRecognizer.numberOfTouchesRequired = 1
        swipeGestureRecognizer.direction = .up
        addGestureRecognizer(swipeGestureRecognizer)
        isUserInteractionEnabled = true
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    func setup(with model: TripleCenterFrame) {
        topLeftImageView.image = model.topLeftImage
        topRightImageView.image = model.topRightImage
        bottomImageView.image = model.bottomImage
    }
    
    // MARK: - Action
    
    @IBAction func onTapButton(sender: UIButton) {
        if sender == topLeftButton {
            delegate?.frameView(self, didTapButton: topLeftButton, imageView: topLeftImageView)
        } else if sender == topRightButton {
            delegate?.frameView(self, didTapButton: topRightButton, imageView: topRightImageView)
        } else if sender == bottomButton {
            delegate?.frameView(self, didTapButton: bottomButton, imageView: bottomImageView)
        }
    }
    @objc func swipeView(_ sender: UISwipeGestureRecognizer) {
        delegate?.userDidSwipe(self)
    }
    @objc func onScreenRotated() {
        if UIDevice.current.orientation.isLandscape {
            swipeGestureRecognizer.direction = .left
        } else {
            swipeGestureRecognizer.direction = .up
        }
    }
}



