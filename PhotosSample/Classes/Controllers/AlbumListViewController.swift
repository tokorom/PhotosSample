//
//  AlbumListViewController.swift
//
//  Created by ToKoRo on 2014-07-11.
//

import UIKit
import Photos

class AlbumListViewController: BaseTableViewController {
    
    var collections: PHFetchResult!
    var _overlayScrollView: UIScrollView!

// MARK: - Lifecycle

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        self.loadContents()
    }

    func loadContents() {
        self.collections = PHCollectionList.fetchTopLevelUserCollectionsWithOptions(nil)
        self.tableView.reloadData()
    }

}

// MARK: - UITableViewDataSource

extension AlbumListViewController: UITableViewDataSource {

    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.collections.count
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("AlbumCell", forIndexPath: indexPath) as UITableViewCell
        if let collection = self.collections.optionalValueAtIndex(indexPath.row) as? PHAssetCollection {
            cell.updateWithModel(collection)
        }
        return cell
    }   
}

// MARK: - UITableViewDelegate

extension AlbumListViewController: UITableViewDelegate {

    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        if let collection = self.collections.optionalValueAtIndex(indexPath.row) as? PHAssetCollection {
            let options = ["collection": collection]
            self.performSegueWithIdentifier("ToPhotos", options: options)
        } else {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }

}

// MARK: - PhotoViewerContained

extension AlbumListViewController: PhotoViewerContained {

    var overlayScrollView: UIScrollView! {
        get {
            return self._overlayScrollView
        }
        set (scrollView) {
            self._overlayScrollView = scrollView
        }
    }

    var contentScrollView: UIScrollView! {
        return self.tableView
    }

}

// MARK: - UIScrollViewDelegate

extension AlbumListViewController: UIScrollViewDelegate {

    override func scrollViewDidScroll(scrollView: UIScrollView!) {
        if let overlayScrollView = self._overlayScrollView {
            overlayScrollView.delegate.scrollViewDidScroll?(scrollView)
        }
    }

}
