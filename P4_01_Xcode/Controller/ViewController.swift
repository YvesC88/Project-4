//
//  ViewController.swift
//  P4_01_Xcode
//
//  Created by Yves Charpentier on 29/06/2021.
//

import UIKit

protocol ViewControllerDelegate: AnyObject {
    func frameView(_ frameView: UIView, didTapButton button: UIButton, imageView: UIImageView)
    func userDidSwipe(_ frameView: UIView)
}

class ViewController: UIViewController {
    @IBOutlet weak var frameViewCenter: FrameView!
    @IBOutlet weak var selectedLayoutCenter: UIImageView!
    
    @IBOutlet weak var frameViewLeft: FrameView!
    @IBOutlet weak var selectedLayoutLeft: UIImageView!
    
    @IBOutlet weak var frameViewRight: FrameView!
    @IBOutlet weak var selectedLayoutRight: UIImageView!
    
    @IBOutlet var quadrupleFrameView: QuadrupleFrameView!
    @IBOutlet var tripleLeftFrameView: TripleLeftFrameView!
    @IBOutlet var tripleCenterFrameView: TripleCenterFrameView!
    
    @IBOutlet var swipeUpLabel: UILabel!
    @IBOutlet var arrowUpImage: UIImageView!
    
    @IBOutlet var swipeLeftLabel: UILabel!
    @IBOutlet var arrowLeftImage: UIImageView!
    
    var imageViewToFill: UIImageView?
    
    //MARK: Object lifecylce
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    //MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
        
        tripleCenterFrameView.delegate = self
        tripleLeftFrameView.delegate = self
        tripleLeftFrameView.isHidden = true
        quadrupleFrameView.delegate = self
        quadrupleFrameView.isHidden = true
        
        // Do any additional setup after loading the view.
        let tapGestureRecognizerCenter = UITapGestureRecognizer(target: self, action: #selector(tapFrameViewCenter(_:)))
        frameViewCenter.addGestureRecognizer(tapGestureRecognizerCenter)
        
        let tapGestureRecognizerLeft = UITapGestureRecognizer(target: self, action: #selector(tapFrameViewLeft(_:)))
        frameViewLeft.addGestureRecognizer(tapGestureRecognizerLeft)
        
        let tapGestureRecognizerRight = UITapGestureRecognizer(target: self, action: #selector(tapFrameViewRight(_:)))
        frameViewRight.addGestureRecognizer(tapGestureRecognizerRight)
    }
    
    //MARK: Private
    
    func pickImage() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    @objc func rotated() {
        if UIDevice.current.orientation.isLandscape {
            swipeUpLabel.isHidden = true
            arrowUpImage.isHidden = true
            swipeLeftLabel.isHidden = false
            arrowLeftImage.isHidden = false
            
        } else {
            swipeUpLabel.isHidden = false
            arrowUpImage.isHidden = false
            swipeLeftLabel.isHidden = true
            arrowLeftImage.isHidden = true
        }
    }
    
    
    @objc func tapFrameViewCenter(_ sender: UITapGestureRecognizer) {
        selectedLayoutCenter.isHidden = false
        selectedLayoutLeft.isHidden = true
        selectedLayoutRight.isHidden = true
        quadrupleFrameView.isHidden = true
        tripleLeftFrameView.isHidden = true
        tripleCenterFrameView.isHidden = false
    }
    
    @objc func tapFrameViewLeft(_ sender: UITapGestureRecognizer) {
        selectedLayoutLeft.isHidden = false
        selectedLayoutCenter.isHidden = true
        selectedLayoutRight.isHidden = true
        quadrupleFrameView.isHidden = true
        tripleCenterFrameView.isHidden = true
        tripleLeftFrameView.isHidden = false
    }
    
    @objc func tapFrameViewRight(_ sender: UITapGestureRecognizer) {
        selectedLayoutRight.isHidden = false
        selectedLayoutCenter.isHidden = true
        selectedLayoutLeft.isHidden = true
        quadrupleFrameView.isHidden = false
        tripleLeftFrameView.isHidden = true
        tripleCenterFrameView.isHidden = true
    }
}

extension ViewController: ViewControllerDelegate {
    
    func frameView(_ frameView: UIView, didTapButton button: UIButton, imageView: UIImageView) {
        imageViewToFill = imageView
        pickImage()
    }
    func uiImage(_ view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            view.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
    
    //MARK: - Share
    
    func share(view: UIView) {
        let shareView = uiImage(view)
        let activityViewController = UIActivityViewController(
            activityItems: [shareView as Any], applicationActivities: nil)
        activityViewController.isModalInPresentation = true
        activityViewController.completionWithItemsHandler = { [weak self] _, _, _, _ in
            self?.userSwipeDidCancel(view)
        }
        present(activityViewController, animated: true, completion: nil)
    }
    
    //MARK: - Animation
    
    func userDidSwipe(_ frameView: UIView) {
        if UIDevice.current.orientation.isLandscape {
            let screenWidth = UIScreen.main.bounds.width
            let translationTransform = CGAffineTransform(translationX: -screenWidth, y: 0)
            UIView.animate(withDuration: 0.8) {
                frameView.transform = translationTransform
            }
        } else {
            let screenHeight = UIScreen.main.bounds.height
            let translationTransform = CGAffineTransform(translationX: 0, y: -screenHeight)
            UIView.animate(withDuration: 0.8) {
                frameView.transform = translationTransform
            }
        }
        
        share(view: frameView)
    }
    
    func userSwipeDidCancel(_ frameView: UIView) {
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.9, options: [], animations: {
            frameView.transform = .identity
        }, completion: nil)
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            imageViewToFill?.image = image
        }
        imageViewToFill = nil
        picker.dismiss(animated: true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
