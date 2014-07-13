//
//  PhotosCollectionViewController.swift
//
//  Created by ToKoRo on 2014-07-09.
//

import UIKit
import Photos

class PhotosCollectionViewController: UICollectionViewController {

    var collection: PHAssetCollection!
    var assets: PHFetchResult!
    var _overlayScrollView: UIScrollView!

// MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        if let collection = self.segueOptions?["collection"] as? PHAssetCollection {
            self.collection = collection
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        self.loadContents()
    }

    func loadContents() {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        if let collection = self.collection {
            self.assets = PHAsset.fetchAssetsInAssetCollection(collection, options: fetchOptions)
        } else {
            self.assets = PHAsset.fetchAssetsWithMediaType(PHAssetMediaType.Image, options: fetchOptions)
        }
        self.collectionView.reloadData()
    }

}

// MARK: - UICollectionViewDataSource

extension PhotosCollectionViewController: UICollectionViewDataSource {

    override func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
        if let assets = self.assets {
            return assets.count
        }
        return 0
    }

    override func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PhotoCell", forIndexPath: indexPath) as UICollectionViewCell
        if let asset = self.assets?.optionalValueAtIndex(indexPath.row) as? PHAsset {
            cell.updateWithModel(asset)
        }
        return cell
    }

}

// MARK: - PhotoViewerContained

extension PhotosCollectionViewController: PhotoViewerContained {

    var overlayScrollView: UIScrollView! {
        get {
            return self._overlayScrollView
        }
        set (scrollView) {
            self._overlayScrollView = scrollView
        }
    }

    var contentScrollView: UIScrollView! {
        return self.collectionView
    }

}

// MARK: - UIScrollViewDelegate

extension PhotosCollectionViewController: UIScrollViewDelegate {

    override func scrollViewDidScroll(scrollView: UIScrollView!) {
        if let overlayScrollView = self._overlayScrollView {
            overlayScrollView.delegate.scrollViewDidScroll?(scrollView)
        }
    }

}
