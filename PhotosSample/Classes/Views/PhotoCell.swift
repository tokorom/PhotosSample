//
//  PhotoCell.swift
//
//  Created by ToKoRo on 2014-07-09.
//

import UIKit
import Photos

class PhotoCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView
    
    override func updateWithModel(model: AnyObject) {
        if let asset = model as? PHAsset {
            let imageManager = PHCachingImageManager.defaultManager()
            imageManager.requestImageForAsset(
                asset, 
                targetSize: CGSizeMake(106, 106),
                contentMode: PHImageContentMode.AspectFill,
                options: nil
            ) { image, info in
                self.imageView.image = image
            }
        }
    }

}
