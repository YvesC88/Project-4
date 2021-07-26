//
//  TripleLeftFrameView.swift
//  P4_01_Xcode
//
//  Created by Yves Charpentier on 06/07/2021.
//

import Foundation
import UIKit

class TripleLeftFrameView: UIView {
    
    @IBOutlet var topImageView: UIImageView!
    @IBOutlet var bottomLeftImageView: UIImageView!
    @IBOutlet var bottomRightImageView: UIImageView!
    
    @IBOutlet var topButton: UIButton!
    @IBOutlet var bottomLeftButton: UIButton!
    @IBOutlet var bottomRightButton: UIButton!
    
    weak var delegate: ViewControllerDelegate?
    var swipeGestureRecognizer: UISwipeGestureRecognizer!
    
    //MARK: - Object lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        topImageView?.backgroundColor = .clear
        bottomLeftImageView?.backgroundColor = .clear
        bottomRightImageView?.backgroundColor = .clear
        
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
    
    func setup(with model: TripleLeftFrame) {
        topImageView.image = model.topImage
        bottomLeftImageView.image = model.bottomLeftImage
        bottomRightImageView.image = model.bottomRightImage
    }
    
    //MARK: - Action
    
    @IBAction func onTapButton(sender: UIButton) {
        if sender == topButton {
            delegate?.frameView(self, didTapButton: topButton, imageView: topImageView)
        } else if sender == bottomLeftButton {
            delegate?.frameView(self, didTapButton: bottomLeftButton, imageView: bottomLeftImageView)
        } else if sender == bottomRightButton {
            delegate?.frameView(self, didTapButton: bottomRightButton, imageView: bottomRightImageView)
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
