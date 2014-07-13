//
//  PhotosCollectionViewController.swift
//
//  Created by ToKoRo on 2014-07-09.
//

import UIKit
import Photos

class PhotosCollectionViewController: UICollectionViewController {

    var assets: PHFetchResult!
    var _overlayScrollView: UIScrollView!

// MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

/*         if let options = self.segueOptions?.value as? Dictionary {
            self.assets = options["collection"]
        } */
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        self.loadContents()
    }

    func loadContents() {
        if !self.assets {
            self.assets = PHAsset.fetchAssetsWithMediaType(PHAssetMediaType.Image, options: nil)
        }
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
        if let asset = self.assets.optionalValueAtIndex(indexPath.row) as? PHAsset {
/*         if let asset = self.assets[indexPath.row] as? PHAsset { */
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
