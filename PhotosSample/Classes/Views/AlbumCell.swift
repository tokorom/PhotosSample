//
//  AlbumCell.swift
//
//  Created by ToKoRo on 2014-07-13.
//

import UIKit
import Photos

class AlbumCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView
    @IBOutlet weak var titleLabel: UILabel
    
    override func updateWithModel(model: AnyObject) {
        if let collection = model as? PHAssetCollection {
            self.titleLabel.text = collection.localizedTitle
            self.updateThumbnailImageWithCollection(collection)
        }
    }

// MARK: - Private Methods
    
    func updateThumbnailImageWithCollection(collection: PHAssetCollection) {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        let results = PHAsset.fetchAssetsInAssetCollection(collection, options: fetchOptions)
        if 0 < results.count {
            if let asset = results[0] as? PHAsset {
                let imageManager = PHCachingImageManager.defaultManager()
                imageManager.requestImageForAsset(
                    asset, 
                    targetSize: CGSizeMake(88, 88),
                    contentMode: PHImageContentMode.AspectFill,
                    options: nil
                ) { image, info in
                    self.thumbnailImageView.image = image
                }
            }
        }
    }

}
