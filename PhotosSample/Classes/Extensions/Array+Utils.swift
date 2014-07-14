//
//  Array+Utils.swift
//
//  Created by ToKoRo on 2014-07-14.
//

extension Array {

    var first: T? {
        return self.isEmpty ? nil : self[0]
    }

    var last: T? {
        return self.isEmpty ? nil : self[self.count - 1]
    }

    func optionalValueAtIndex(index: Int) -> T! {
        return index < self.count ? self[index] : nil
    }

}
