//
//  ViewController.swift
//  Filterer
//
//  Created by Алексей Удалов on 20/09/16.
//  Copyright © 2016 udalovas. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var newPhotoButton: UIButton!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var secondaryMenu: UIView!
    
    @IBOutlet var bottomMenu: UIView!
    @IBOutlet weak var filterButton: UIButton!
    
    private var rgbaOriginalImage: RGBAImage?
    private var originalImage: UIImage?

    @IBAction func onNewPhoto(sender: UIButton) {
        
        let photoActionSheet = UIAlertController(title: "New Photo", message: nil, preferredStyle: .ActionSheet)
        
        photoActionSheet.popoverPresentationController?.sourceView = newPhotoButton
        
        photoActionSheet.addAction(UIAlertAction(title: "Camera", style: .Default, handler: { action in
            self.showCamera()
        }))

        photoActionSheet.addAction(UIAlertAction(title: "Album", style: .Default, handler: { action in
            self.showAlbum()
        }))
        
        photoActionSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        self.presentViewController(photoActionSheet, animated: true, completion: nil)
    }
    
    func showCamera() {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func showAlbum() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .PhotoLibrary
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)
        imageView.image = (info[UIImagePickerControllerOriginalImage] as! UIImage)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onShare(sender: UIButton) {
    }
    
    @IBAction func onFilter(sender: UIButton) { 
        if(!sender.selected) {
            showSecondaryMenu()
        } else {
            hideSecondaryMenu()
        }
        sender.selected = !sender.selected
    }
    
    func showSecondaryMenu() {
        
        view.addSubview(secondaryMenu)
        
        let bottomConstraint = secondaryMenu.bottomAnchor.constraintEqualToAnchor(bottomMenu.topAnchor)
        let leftConstraint = secondaryMenu.leftAnchor.constraintEqualToAnchor(bottomMenu.leftAnchor)
        let rightConstraint = secondaryMenu.rightAnchor.constraintEqualToAnchor(bottomMenu.rightAnchor)
        
        let heightConstraint = secondaryMenu.heightAnchor.constraintEqualToConstant(44)
        
        NSLayoutConstraint.activateConstraints([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
        
        view.layoutIfNeeded()
        
        self.secondaryMenu.alpha = 0
        UIView.animateWithDuration(0.4) { 
            self.secondaryMenu.alpha = 1
        }
    }
    
    func hideSecondaryMenu () {
        
        UIView.animateWithDuration(0.4, animations: { 
            self.secondaryMenu.alpha = 0
            }) { (completed) in
                if(completed == true) {
                    self.secondaryMenu.removeFromSuperview()
                }
        }
    }
    
    func onApplyFilterClick(sender: UIButton) {
        if(sender.selected) {
            imageView.image = originalImage
        } else {
            imageView.image = GrayScaleFilter.INSTANCE.apply(&rgbaOriginalImage!).toUIImage()
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        secondaryMenu.translatesAutoresizingMaskIntoConstraints = false
        secondaryMenu.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        
        originalImage = UIImage(named: "london")
        rgbaOriginalImage = RGBAImage(image: originalImage!)
        
        imageView.image = originalImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

