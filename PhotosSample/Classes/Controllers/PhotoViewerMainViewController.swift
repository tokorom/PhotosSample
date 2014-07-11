//
//  PhotoViewerMainViewController.swift
//
//  Created by ToKoRo on 2014-07-10.
//

import Foundation
import UIKit

class PhotoViewerMainViewController: BaseViewController {

    @IBOutlet weak var overlayScrollView: UIScrollView
    weak var contained: PhotoViewerContained!

    override func viewDidLoad() {
        super.viewDidLoad()

        assert(self.childViewControllers[0] as? PhotoViewerContained, "PhotoViewerMainViewController has no PhotoViewerContained")

/*         if let subject = self.childViewControllers[0] as? NSObject {
            self.observe(subject, keyPath: "contentScrollView.contentSize") {
                if let contained = subject as? PhotoViewerContained {
                    self.overlayScrollView.contentSize = contained.contentScrollView.contentSize
                }
            }
        } */

        if let contained = self.childViewControllers[0] as? PhotoViewerContained {
            self.contained = contained
            contained.contentScrollView.delegate = self
            self.overlayScrollView.addGestureRecognizer(contained.contentScrollView.panGestureRecognizer)
        }
    }

}

// MARK: - UIScrollViewDelegate

extension PhotoViewerMainViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(scrollView: UIScrollView!) {
        self.overlayScrollView.contentOffset = self.contained.contentScrollView.contentOffset
    }

}
