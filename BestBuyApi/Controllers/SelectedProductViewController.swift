//
//  SelectedProductViewController.swift
//  BestBuyApi
//
//  Created by Ana Finotti on 11/18/16.
//  Copyright © 2016 Ana Finotti. All rights reserved.
//

import UIKit
import SDWebImage
import SKPhotoBrowser

class SelectedProductViewController: UIViewController {

    @IBOutlet var selectedProductImageView: UIImageView!
    @IBOutlet var productDescriptionLabel: UILabel!
    @IBOutlet var productPriceLabel: UILabel!
    @IBOutlet var shareButton: UIButton!
    @IBOutlet var containerView: UIView!
    
    var selectedProduct: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupSelectedProduct()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func setupSelectedProduct() {
        self.containerView.clipsToBounds = true
        self.containerView.layer.cornerRadius = 0
        self.containerView.layer.borderWidth = 1
        self.containerView.layer.borderColor = UIColor(red:0.40, green:0.20, blue:0.60, alpha:1.0).cgColor
        
        self.shareButton.clipsToBounds = true
        self.shareButton.layer.cornerRadius = 2
        self.shareButton.layer.borderWidth = 1
        self.shareButton.backgroundColor = UIColor(red:0.40, green:0.20, blue:0.60, alpha:1.0)
        
        self.productDescriptionLabel.text = selectedProduct?.name
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        self.productPriceLabel.text =  formatter.string(for: selectedProduct?.salePrice)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(SelectedProductViewController.presentImageFromUrl))
        tap.numberOfTapsRequired = 1
        self.selectedProductImageView.isUserInteractionEnabled = true
        self.selectedProductImageView.addGestureRecognizer(tap)
        
        self.selectedProductImageView.sd_setImage(with: NSURL(string: (selectedProduct?.image!)!) as URL!, placeholderImage: UIImage(), options: SDWebImageOptions.highPriority) {
            (image, error, cache, url) in
            self.selectedProductImageView.image = image
        }
    }
    
    func presentImageFromUrl() {
        // 1. create URL Array
        var images = [SKPhoto]()
        let photo = SKPhoto.photoWithImageURL((self.selectedProduct?.image!)!)
        photo.shouldCachePhotoURLImage = false
        images.append(photo)
        
        // 2. create PhotoBrowser Instance, and present.
        let browser = SKPhotoBrowser(photos: images)
        browser.initializePageIndex(0)
        present(browser, animated: true, completion: {})
    }
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        let objectsToShare = [self.selectedProduct?.name, self.selectedProduct?.image]
        let activityViewController: UIActivityViewController = UIActivityViewController.init(activityItems: objectsToShare, applicationActivities: nil)

        self.present(activityViewController, animated: true, completion: {
        })
    }
}
