//
//  PhotoViewerMainViewController.swift
//
//  Created by ToKoRo on 2014-07-10.
//

import Foundation
import UIKit

class PhotoViewerMainViewController: BaseViewController {

    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var overlayScrollView: UIScrollView!
    @IBOutlet weak var containerView: UIView!
    weak var contained: PhotoViewerContained!
    weak var containedViewController: UIViewController!

// MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.replaceContainedViewControllerAtIndex(0)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if let contained = self.contained {
            contained.contentScrollView.contentInset.top = self.contentInsetForChilds()
        }
    }

// MARK: - Actions

    @IBAction func segmentedDidChange(segmentedControl: UISegmentedControl!) {
        self.replaceContainedViewControllerAtIndex(segmentedControl.selectedSegmentIndex)
    }
}


// MARK: - UIScrollViewDelegate

extension PhotoViewerMainViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(scrollView: UIScrollView!) {
        if let overlayScrollView = self.overlayScrollView {
            var offset = self.contained.contentScrollView.contentOffset
            offset.y += self.contentInsetForChilds()
            overlayScrollView.contentOffset = offset
        }
    }

}

// MARK: - Private Methods

extension PhotoViewerMainViewController {

    func contentInsetForChilds() -> CGFloat {
        if let topBar = self.topBar {
            return self.topLayoutGuide.length + CGRectGetHeight(self.topBar.bounds)
        } else {
            return self.topLayoutGuide.length
        }
    }

    func replaceContainedViewControllerAtIndex(index: Int) {
        self.containedViewController?.willMoveToParentViewController(self)
        self.containedViewController?.removeFromParentViewController()

        var controllerIdentifier: String? = nil
        switch index {
        case 0:
            controllerIdentifier = "PhotosCollectionViewController"
        case 1:
            controllerIdentifier = "AlbumListViewController"
        default:
            controllerIdentifier = "PhotosCollectionViewController"
        }
        if let viewController = self.storyboard.instantiateViewControllerWithIdentifier(controllerIdentifier) as? UIViewController {
            self.addChildViewController(viewController)
            viewController.didMoveToParentViewController(self)
            viewController.view.frame = self.containerView.bounds
            self.containerView.addSubview(viewController.view)
            self.containedViewController = viewController
        }

        assert(self.childViewControllers[0] as? PhotoViewerContained, "PhotoViewerMainViewController has no PhotoViewerContained")

        if let contained = self.childViewControllers[0] as? PhotoViewerContained {
            self.overlayScrollView.delegate = self
            contained.overlayScrollView = self.overlayScrollView
            self.contained = contained
        }

        self.viewDidLayoutSubviews()
    }

}
