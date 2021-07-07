//
//  ViewController.swift
//  P4_01_Xcode
//
//  Created by Yves Charpentier on 29/06/2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var frameView: FrameView!
    @IBOutlet weak var selectedLayout: UIImageView!
    
    @IBOutlet weak var frameView1: FrameView!
    @IBOutlet weak var selectedLayout1: UIImageView!
    
    @IBOutlet weak var frameView3: FrameView!
    @IBOutlet weak var selectedLayout3: UIImageView!
    
    @IBOutlet var quadrupleFrameView: QuadrupleFrameView!
    @IBOutlet var tripleLeftFrameView: TripleLeftFrameView!
    @IBOutlet var tripleCenterFrameView: TripleCenterFrameView!
    
    var imageViewToFill: UIImageView?
    func showImage() {
    let vc = UIImagePickerController()
    vc.sourceType = .photoLibrary
    vc.delegate = self
    vc.allowsEditing = true
    present(vc, animated: true)
    }
    // top left image
    @IBOutlet weak var topLeftImageView: UIImageView!
    @IBOutlet weak var topLeftButtonImageView: UIButton!
    // top right image
    @IBOutlet weak var topRightImageView: UIImageView!
    @IBOutlet weak var topRightButtonImageView: UIButton!
    // bottom left image
    @IBOutlet weak var bottomLeftImageView: UIImageView!
    @IBOutlet weak var bottomLeftButtonImageView: UIButton!
    // bottom right image
    @IBOutlet weak var bottomRightImageView: UIImageView!
    @IBOutlet weak var bottomRightButtonImageView: UIButton!
    
    @IBAction func didTapTopLeftImageView() {
        showImage()
        topLeftButtonImageView.isHidden = true
        imageViewToFill = topLeftImageView
    }
    @IBAction func didTapTopRightImageView() {
        showImage()
        topRightButtonImageView.isHidden = true
        imageViewToFill = topRightImageView
    }
    @IBAction func didTapBottomLeftImageView() {
        showImage()
        bottomLeftButtonImageView.isHidden = true
        imageViewToFill = bottomLeftImageView
    }
    @IBAction func didTapTopBottomRightImageView() {
        showImage()
        bottomRightButtonImageView.isHidden = true
        imageViewToFill = bottomRightImageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quadrupleFrameView.isHidden = true
        
        // Do any additional setup after loading the view.
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(tapFrameViewCenter(_:)))
        frameView.addGestureRecognizer(tapGestureRecognizer1)
        
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(tapFrameViewLeft(_:)))
        frameView1.addGestureRecognizer(tapGestureRecognizer2)
        
        let tapGestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(tapFrameViewRight(_:)))
        frameView3.addGestureRecognizer(tapGestureRecognizer3)
    }
    
    @objc func tapFrameViewCenter(_ sender: UITapGestureRecognizer) {
        selectedLayout.isHidden = false
        selectedLayout1.isHidden = true
        selectedLayout3.isHidden = true
        quadrupleFrameView.isHidden = true
        tripleLeftFrameView.isHidden = true
        tripleCenterFrameView.isHidden = false
    }
    
    @objc func tapFrameViewLeft(_ sender: UITapGestureRecognizer) {
        selectedLayout1.isHidden = false
        selectedLayout.isHidden = true
        selectedLayout3.isHidden = true
        quadrupleFrameView.isHidden = true
        tripleCenterFrameView.isHidden = true
        tripleLeftFrameView.isHidden = false
    }
    
    @objc func tapFrameViewRight(_ sender: UITapGestureRecognizer) {
        selectedLayout3.isHidden = false
        selectedLayout.isHidden = true
        selectedLayout1.isHidden = true
        quadrupleFrameView.isHidden = false
        tripleLeftFrameView.isHidden = true
        tripleCenterFrameView.isHidden = true
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
