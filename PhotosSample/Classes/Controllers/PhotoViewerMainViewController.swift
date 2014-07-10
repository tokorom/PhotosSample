//
//  PhotoViewerMainViewController.swift
//
//  Created by ToKoRo on 2014-07-10.
//

import Foundation
import UIKit

@objc class PhotoViewerMainViewController: UIViewController {

    @IBOutlet weak var overlayScrollView: UIScrollView
    
    var string: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        assert(self.childViewControllers[0] as? PhotoViewerContained, "PhotoViewerMainViewController has no PhotoViewerContained")

/*         if let contained = self.childViewControllers[0] as? PhotoViewerContained {
            let options: NSKeyValueObservingOptions = .New
            contained.addObserver(self, forKeyPath: "contentScrollView.contentSize", options: options, context: nil)
        } */

        if let subject = self.childViewControllers[0] as? NSObject {
            let options: NSKeyValueObservingOptions = .New
            subject.addObserver(self, forKeyPath: "contentScrollView.contentSize", options: options, context: nil)
        }


/*             let options: NSKeyValueObservingOptions = .New
            self.addObserver(self, forKeyPath: "string", options: options, context: nil)

            self.string = "123" */

/*         if let contained = self.childViewControllers[0] as? PhotoViewerContained {
            self.overlayScrollView.contentSize = contained.contentScrollView.contentSize
            println("size = \(self.overlayScrollView.contentSize)");
        } */
    }

    override func observeValueForKeyPath(keyPath: String!, ofObject object: AnyObject!, change: [NSObject : AnyObject]!, context: UnsafePointer<()>) {
        println("observeValueForKey: \(keyPath)")
        println("observeValueForKey: \(object)")
        println("observeValueForKey: \(change)")
    }

}
