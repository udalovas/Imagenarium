//
//  ViewController.swift
//  Filterer
//
//  Created by Алексей Удалов on 20/09/16.
//  Copyright © 2016 udalovas. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    /* Constants */
    
    private static let FADE_ANIMATION_DURATION:NSTimeInterval = 0.4
    
    /* Controls */
    
    @IBOutlet var newPhotoButton: UIButton!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var secondaryMenu: UIView!
    @IBOutlet var filtersContainer: UIStackView!
    @IBOutlet var bottomMenu: UIView!
    @IBOutlet var filterButton: UIButton!
    
    private var filterButtons:[UIButton] = []
    
    /* State */
    
    private var originalRGBAImage: RGBAImage?
    private var originalImage: UIImage?
    
    private var filteredRGBAImage: RGBAImage?
    private var filteredImage: UIImage?

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
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)
        imageView.image = (info[UIImagePickerControllerOriginalImage] as! UIImage)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onShare(sender: UIButton) {
        let activityController = UIActivityViewController(activityItems: [imageView.image!], applicationActivities: nil)
        presentViewController(activityController, animated: true, completion: nil)
    }
    
    @IBAction func onFilterMenu(sender: UIButton) {
        if(!sender.selected) {
            showSecondaryMenu()
        } else {
            hideSecondaryMenu()
        }
        sender.selected = !sender.selected
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        initImage()
        initFilterMenu()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func showCamera() {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    private func showAlbum() {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .PhotoLibrary
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func showSecondaryMenu() {
        
        view.addSubview(secondaryMenu)
        
        // TODO: check that we really need to calculate constraints each time..
        
        let bottomConstraint = secondaryMenu.bottomAnchor.constraintEqualToAnchor(bottomMenu.topAnchor)
        let leftConstraint = secondaryMenu.leftAnchor.constraintEqualToAnchor(bottomMenu.leftAnchor)
        let rightConstraint = secondaryMenu.rightAnchor.constraintEqualToAnchor(bottomMenu.rightAnchor)
        let heightConstraint = secondaryMenu.heightAnchor.constraintEqualToConstant(44)
        
        NSLayoutConstraint.activateConstraints([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
        
        view.layoutIfNeeded()
        
        self.secondaryMenu.alpha = 0
        UIView.animateWithDuration(ViewController.FADE_ANIMATION_DURATION) {
            self.secondaryMenu.alpha = 1
        }
    }
    
    private func hideSecondaryMenu () {
        
        UIView.animateWithDuration(ViewController.FADE_ANIMATION_DURATION, animations: {
            self.secondaryMenu.alpha = 0
        }) { completed in
            if(completed == true) {
                self.secondaryMenu.removeFromSuperview()
            }
        }
    }
    
    func onFilterTap(sender: UIButton) {
        
        if(sender.selected) {
            imageView.image = originalImage
        } else {
            // reset all neibours
            filterButtons.filter { (button) -> Bool in
                button != sender
                }.forEach { (button) in
                    button.selected = false
                }
            // apply new filter
            filteredRGBAImage = ImageProcessor.getFilter(sender.currentTitle!).apply(originalRGBAImage!)
            filteredImage = filteredRGBAImage?.toUIImage()
            imageView.image = filteredImage!
        }
        sender.selected = !sender.selected
    }
    
    private func initFilterMenu() {
        
        secondaryMenu.translatesAutoresizingMaskIntoConstraints = false
        secondaryMenu.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        
        for filter in ImageProcessor.FilterType.all {
            
            let filterButton = UIButton(type: .System)
            filterButton.setTitle(filter.rawValue, forState: .Normal)
            filterButton.addTarget(self, action: #selector(ViewController.onFilterTap(_:)), forControlEvents: .TouchUpInside)
            
            filtersContainer.addArrangedSubview(filterButton)
            filterButtons.append(filterButton)
        }
    }
    
    private func initImage() {
        
        originalImage = UIImage(named: "default")
        originalRGBAImage = RGBAImage(image: originalImage!)
        
        imageView.image = originalImage
    }
}

