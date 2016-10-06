//
//  ViewController.swift
//  Imagenarium
//
//  Created by Алексей Удалов on 20/09/16.
//  Copyright © 2016 udalovas. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    /* Constants */
    
    private static let FADE_ANIMATION_DURATION:NSTimeInterval = 0.4
    private static let FILTER_MENU_HEIGHT:UInt8 = 50
    
    /* Controls */
    
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var originalImageView: UIImageView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var filtersCollectionView: UICollectionView!
    @IBOutlet var bottomMenu: UIView!
    @IBOutlet var filterButton: UIButton!
    @IBOutlet var compareButton: UIButton!
    @IBOutlet var newPhotoButton: UIButton!
    
    /* State */
    
    private var originalRGBAImage: RGBAImage?
    private var originalImage: UIImage?
    private var filteredRGBAImage: RGBAImage?
    private var filteredImage: UIImage?
    
    /* Action! */

    @IBAction func onNewPhoto(sender: UIButton) {
        // TODO need to create each time?..
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
    
    @IBAction func onShare(sender: UIButton) {
        presentViewController(UIActivityViewController(activityItems: [imageView.image!], applicationActivities: nil), animated: true, completion: nil)
    }
    
    @IBAction func onFilterMenu(sender: UIButton) {
        if(!sender.selected) {
            showFiltersCollection()
        } else {
            hide(filtersCollectionView)
        }
        sender.selected = !sender.selected
    }
    
//    @IBAction func onFilterTap(sender: UIButton) {
//        
//        if(sender.selected) {
//            imageView.image = originalImage
//            compareButton.enabled = false
//        } else {
//            // state
//            filteredRGBAImage = RGBAImage(image: sender.currentBackgroundImage!)
//            filteredImage = sender.currentBackgroundImage
//            // view
//            filterButtons
//                .filter { button -> Bool in
//                    button != sender
//                }.forEach { button in
//                    button.selected = false
//            }
//            compareButton.enabled = true
//            imageView.image = sender.currentBackgroundImage
//        }
//        sender.selected = !sender.selected
//    }
    
    @IBAction func onImageTap(sender: UIImageView) {
        imageView.image = originalImage // TODO test on device
    }
    
    /* UIImagePickerControllerDelegate: start */
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)
        updateOriginalImage(info[UIImagePickerControllerOriginalImage] as! UIImage)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /* UIImagePickerControllerDelegate: end */
    
    /* UICollectionViewDataSource */
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ImageProcessor.FilterType.all.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = filtersCollectionView.dequeueReusableCellWithReuseIdentifier("FilterCell", forIndexPath: indexPath) as! FilterCellView
        // compress before?
        let image = ImageProcessor.getFilter(ImageProcessor.FilterType.all[indexPath.row].rawValue).apply(originalRGBAImage!).toUIImage()
        cell.labelView.text = ImageProcessor.FilterType.all[indexPath.row].rawValue
        cell.imageView.image = image
        cell.layoutIfNeeded()
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("filterIsSelected " + String(indexPath.row))
    }
    
    /* UICollectionViewDataSource: end */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initImageViews()
        initCompareButton()
        initFilterMenu()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated..
    }
    
    @IBAction func onCompareTouchDown(sender: UIButton) {
        if(sender.selected) {
            hideOriginalOverlay()
        } else {
            showOriginalOverlay()
        }
        sender.selected = !sender.selected
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
    
    private func initCompareButton() {
        compareButton.enabled = false
    }
    
    func showFiltersCollection() {
        
        view.addSubview(filtersCollectionView)
        
        let bottomConstraint = filtersCollectionView.bottomAnchor.constraintEqualToAnchor(bottomMenu.topAnchor)
        let leftConstraint = filtersCollectionView.leftAnchor.constraintEqualToAnchor(bottomMenu.leftAnchor)
        let rightConstraint = filtersCollectionView.rightAnchor.constraintEqualToAnchor(bottomMenu.rightAnchor)
        let heightConstraint = filtersCollectionView.heightAnchor.constraintEqualToConstant(CGFloat(ViewController.FILTER_MENU_HEIGHT))
        NSLayoutConstraint.activateConstraints([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
        view.layoutIfNeeded()
        
        show(filtersCollectionView)
    }
    
    func hideFiltersCollection() {
        hide(filtersCollectionView)
    }
    
    func hideOriginalOverlay() {
        hide(originalImageView)
    }
    
    func showOriginalOverlay() {
        view.addSubview(originalImageView)
        let topConstraint = originalImageView.topAnchor.constraintEqualToAnchor(mainStackView.topAnchor)
        let bottomConstraint = originalImageView.bottomAnchor.constraintEqualToAnchor(bottomMenu.topAnchor)
        let leftConstraint = originalImageView.leftAnchor.constraintEqualToAnchor(mainStackView.leftAnchor)
        let rightConstraint = originalImageView.rightAnchor.constraintEqualToAnchor(mainStackView.rightAnchor)
        NSLayoutConstraint.activateConstraints([topConstraint, leftConstraint, rightConstraint, bottomConstraint])
        view.layoutIfNeeded()
        show(originalImageView)
    }
    
    private func hide(view: UIView) {
        UIView.animateWithDuration(ViewController.FADE_ANIMATION_DURATION, animations: {
            view.alpha = 0
        }) { completed in
            if(completed == true) {
                view.removeFromSuperview()
            }
        }
    }
    
    private func show(view: UIView) {
        view.alpha = 0
        UIView.animateWithDuration(ViewController.FADE_ANIMATION_DURATION) {
            view.alpha = 1
        }
    }
    
    private func initFilterMenu() {
        filtersCollectionView.dataSource = self
        filtersCollectionView.delegate = self
        filtersCollectionView.translatesAutoresizingMaskIntoConstraints = false
        filtersCollectionView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        filtersCollectionView.setCollectionViewLayout(UICollectionViewFlowLayout(), animated: true)
    }
    
    private func initImageViews() {
        updateOriginalImage(UIImage(named: "default")!)
        imageView.userInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.onImageTap(_:))))
        imageView.image = originalImage
        originalImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func updateOriginalImage(image: UIImage) {
        originalImage = image
        originalRGBAImage = RGBAImage(image: image)
        originalImageView.image = ImageProcessor.drawText("Original", inImage: originalImage!, atPoint: CGPointMake(20, 20))
        imageView.image = originalImage
    }
    
    private func refreshPreview() {
        // nothing at the moment
    }

}

