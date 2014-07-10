//
//  PhotosCollectionViewController.swift
//
//  Created by ToKoRo on 2014-07-09.
//

import UIKit
import Photos

class PhotosCollectionViewController: UICollectionViewController {

    var assets: PHFetchResult!

// MARK: - Lifecycle

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        self.loadContents()
    }

    func loadContents() {
        self.assets = PHAsset.fetchAssetsWithMediaType(PHAssetMediaType.Image, options: nil)
        self.collectionView.reloadData()
    }

}

// MARK: - UICollectionViewDataSource

extension PhotosCollectionViewController: UICollectionViewDataSource {

    override func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
        return self.assets.count
    }

    override func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PhotoCell", forIndexPath: indexPath) as UICollectionViewCell
        cell.updateWithModel(self.assets[indexPath.row])
        return cell
    }

}

// MARK: - PhotoViewerContained

extension PhotosCollectionViewController: PhotoViewerContained {

    var contentScrollView: UIScrollView! {
        return self.collectionView
    }

}
