//
//  PhotosCollectionViewController.swift
//
//  Created by ToKoRo on 2014-07-09.
//

import UIKit
import Photos

class PhotosCollectionViewController: UICollectionViewController {

    var collection: PHAssetCollection!

    var sectionTitles: [String]!
    var collections: [String : [PHAsset]]!

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

        if !self.collections {
            self.loadContents()
        }
    }

// MARK: - Private Methods

    func loadContents() {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        var result: PHFetchResult! = nil
        if let collection = self.collection {
            result = PHAsset.fetchAssetsInAssetCollection(collection, options: fetchOptions)
            self.collection = nil
        } else {
            result = PHAsset.fetchAssetsWithOptions(fetchOptions)
        }
        self.updateCollectionsWithAssets(result)
        self.collectionView.reloadData()
    }

    func updateCollectionsWithAssets(result: PHFetchResult!) {
        var sectionTitles = [String]()
        var collections = [String : [PHAsset]]()
        var listCount = 0

        var offset = 0
        var lastDateString: String! = nil
        result.enumerateObjectsUsingBlock() { obj, index, stop in
            if let asset = obj as? PHAsset {
                let dateString = NSDateFormatter.localizedStringFromDate(
                    asset.creationDate,
                    dateStyle: .MediumStyle,
                    timeStyle: .NoStyle
                )
                if !lastDateString {
                    lastDateString = dateString
                }
                if (lastDateString != dateString) || (index+1 == result.count) {
                    let length = index - offset
                    let indexSet = NSIndexSet(indexesInRange: NSMakeRange(offset, length))
                    let objects = result.objectsAtIndexes(indexSet)

                    if let assets = objects as? [PHAsset] {
                        sectionTitles += lastDateString
                        collections[lastDateString] = assets
                    }

                    lastDateString = dateString
                    offset += length
                }
            }
        }

        self.sectionTitles = sectionTitles
        self.collections = collections
    }

    func assetsAtSection(section: Int) -> [PHAsset]! {
        if let key = self.sectionTitles.optionalValueAtIndex(section) {
            return self.collections[key]
        }
        return nil
    }

    func assetAtIndexPath(indexPath: NSIndexPath) -> PHAsset! {
        if let assets = self.assetsAtSection(indexPath.section) {
            return assets.optionalValueAtIndex(indexPath.row)
        }
        return nil
    }

}

// MARK: - UICollectionViewDataSource

extension PhotosCollectionViewController: UICollectionViewDataSource {

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView!) -> Int {
        return self.sectionTitles.count
    }

    override func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
        if let assets = self.assetsAtSection(section) {
            return assets.count
        }
        return 0
    }

    override func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PhotoCell", forIndexPath: indexPath) as UICollectionViewCell

        if let asset = self.assetAtIndexPath(indexPath) {
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
