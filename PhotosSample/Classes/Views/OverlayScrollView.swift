//
//  OverlayScrollView.swift
//
//  Created by ToKoRo on 2014-07-13.
//

import UIKit

class OverlayScrollView: UIScrollView {

    /*
    @IBOutlet var wrappedViews: [UIView]
    */
    @IBOutlet var wrappedView: UIView

    override func hitTest(point: CGPoint, withEvent event: UIEvent!) -> UIView! {
        /*
        for view in wrappedViews {
            if CGRectContainsPoint(view.frame, point) {
                return view
            }
        }
        */
        if let view = self.wrappedView {
            let localPoint = self.convertPoint(point, toView: view.superview)
            if CGRectContainsPoint(view.frame, localPoint) {
                return view
            }
        }
        return nil
    }

}
