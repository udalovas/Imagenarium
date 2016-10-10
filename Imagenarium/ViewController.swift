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
    
    fileprivate static let FADE_ANIMATION_DURATION:TimeInterval = 0.4
    fileprivate static let FILTER_MENU_HEIGHT:UInt8 = 50
    fileprivate static let ORIGINAL_LABEL = "Original"
    
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
    
    fileprivate var originalRGBAImage: RGBAImage?
    fileprivate var originalImage: UIImage?
    fileprivate var filteredRGBAImage: RGBAImage?
    fileprivate var filteredImage: UIImage?
    
    /* Action! */

    @IBAction func onNewPhoto(_ sender: UIButton) {
        // TODO need to create each time?..
        let photoActionSheet = UIAlertController(title: "New Photo", message: nil, preferredStyle: .actionSheet)
        photoActionSheet.popoverPresentationController?.sourceView = newPhotoButton
        photoActionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { action in
            self.showCamera()
        }))
        photoActionSheet.addAction(UIAlertAction(title: "Album", style: .default, handler: { action in
            self.showAlbum()
        }))
        photoActionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(photoActionSheet, animated: true, completion: nil)
    }
    
    @IBAction func onShare(_ sender: UIButton) {
        present(UIActivityViewController(activityItems: [imageView.image!], applicationActivities: nil), animated: true, completion: nil)
    }
    
    @IBAction func onFilterMenu(_ sender: UIButton) {
        toggleFilterMenu(!sender.isSelected)
    }
    
    fileprivate func toggleFilterMenu(_ on:Bool) {
        if(on && !filterButton.isSelected) {
            showFiltersCollection()
            filterButton.isSelected = true
        } else if(!on && filterButton.isSelected) {
            hide(filtersCollectionView)
            filterButton.isSelected = false
        }
    }
    
    @IBAction func onImageTap(_ sender: UIImageView) {
        // TODO onTouchDown > show original, onTouchUp > back
//        imageView.image = originalImage
    }
    
    /* UIImagePickerControllerDelegate: start */
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
        updateOriginalImage(info[UIImagePickerControllerOriginalImage] as! UIImage)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    /* UIImagePickerControllerDelegate: end */
    
    /* UICollectionViewDataSource */
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ImageProcessor.FilterType.all.count + 1 // +1 for original image cell
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = filtersCollectionView.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath) as! FilterCellView
        if((indexPath as NSIndexPath).row == 0) {
            cell.labelView.text = ViewController.ORIGINAL_LABEL
            cell.imageView.image = originalImage
        } else {
            // compress before?
            let filterKey = ImageProcessor.FilterType.all[(indexPath as NSIndexPath).row - 1].rawValue
            cell.labelView.text = filterKey
            cell.imageView.image = ImageProcessor.getFilter(filterKey).apply(originalRGBAImage!).toUIImage()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if((indexPath as NSIndexPath).row == 0) {
            imageView.image = originalImage
        } else {
            imageView.image = ImageProcessor
                .getFilter(ImageProcessor.FilterType.all[(indexPath as NSIndexPath).row - 1].rawValue)
                .apply(originalRGBAImage!).toUIImage()
            compareButton.isEnabled = true
        }
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
    
    @IBAction func onCompareTouchDown(_ sender: UIButton) {
        if(sender.isSelected) {
            hideOriginalOverlay()
        } else {
            showOriginalOverlay()
            toggleFilterMenu(false)
        }
        sender.isSelected = !sender.isSelected
    }
    
    fileprivate func showCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    fileprivate func showAlbum() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    fileprivate func initCompareButton() {
        compareButton.isEnabled = false
    }
    
    func showFiltersCollection() {
        
        view.addSubview(filtersCollectionView)
        
        let bottomConstraint = filtersCollectionView.bottomAnchor.constraint(equalTo: bottomMenu.topAnchor)
        let leftConstraint = filtersCollectionView.leftAnchor.constraint(equalTo: bottomMenu.leftAnchor)
        let rightConstraint = filtersCollectionView.rightAnchor.constraint(equalTo: bottomMenu.rightAnchor)
        let heightConstraint = filtersCollectionView.heightAnchor.constraint(equalToConstant: CGFloat(ViewController.FILTER_MENU_HEIGHT))
        NSLayoutConstraint.activate([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
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
        let topConstraint = originalImageView.topAnchor.constraint(equalTo: mainStackView.topAnchor)
        let bottomConstraint = originalImageView.bottomAnchor.constraint(equalTo: bottomMenu.topAnchor)
        let leftConstraint = originalImageView.leftAnchor.constraint(equalTo: mainStackView.leftAnchor)
        let rightConstraint = originalImageView.rightAnchor.constraint(equalTo: mainStackView.rightAnchor)
        NSLayoutConstraint.activate([topConstraint, leftConstraint, rightConstraint, bottomConstraint])
        view.layoutIfNeeded()
        show(originalImageView)
    }
    
    fileprivate func hide(_ view: UIView) {
        UIView.animate(withDuration: ViewController.FADE_ANIMATION_DURATION, animations: {
            view.alpha = 0
        }, completion: { completed in
            if(completed == true) {
                view.removeFromSuperview()
            }
        }) 
    }
    
    fileprivate func show(_ view: UIView) {
        view.alpha = 0
        UIView.animate(withDuration: ViewController.FADE_ANIMATION_DURATION, animations: {
            view.alpha = 1
        }) 
    }
    
    fileprivate func initFilterMenu() {
        filtersCollectionView.dataSource = self
        filtersCollectionView.delegate = self
        filtersCollectionView.translatesAutoresizingMaskIntoConstraints = false
        filtersCollectionView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        filtersCollectionView.setCollectionViewLayout(UICollectionViewFlowLayout(), animated: true)
    }
    
    fileprivate func initImageViews() {
        updateOriginalImage(UIImage(named: "default")!)
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.onImageTap(_:))))
        imageView.image = originalImage
        originalImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    fileprivate func updateOriginalImage(_ image: UIImage) {
        
        originalImage = image
        originalRGBAImage = RGBAImage(image: image)
        originalImageView.image = ImageProcessor.drawText(ViewController.ORIGINAL_LABEL, inImage: originalImage!, atPoint: CGPoint(x: 20, y: 20))
        imageView.image = originalImage
        
        refreshFiltersPreview()
    }
    
    fileprivate func refreshFiltersPreview() {
        self.filtersCollectionView.reloadData()
    }

}

