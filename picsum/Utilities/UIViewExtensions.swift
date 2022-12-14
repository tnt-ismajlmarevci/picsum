//
//  UIViewExtensions.swift
//  imageViewer
//
//  Created by Ismajl Marevci on 12/13/22.
//

import Foundation
import UIKit

//COLOR
extension UIColor {
    public class var accentColor: UIColor {
        return UIColor(named: "AccentColor")!
    }
}

//DEQUEUE REGISTER
extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type, reuseIdentifier: String? = nil) {
        let nib = UINib(nibName: reuseIdentifier ?? String(describing: T.self), bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: reuseIdentifier ?? String(describing: T.self))
    }
    
    func dequeue<T: UICollectionViewCell>(_: T.Type, for indexPath: IndexPath) -> T {
        guard
            let cell = dequeueReusableCell(withReuseIdentifier: String(describing: T.self),
                                           for: indexPath) as? T
        else { fatalError("Could not deque cell with type \(T.self)") }
        
        return cell
    }
}

extension UICollectionView {
    func registerFooter<T: UICollectionReusableView>(_: T.Type, reuseIdentifier: String? = nil) {
        let nib = UINib(nibName: reuseIdentifier ?? String(describing: T.self), bundle: nil)
        
        self.register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: reuseIdentifier ?? String(describing: T.self))
    }
    
    func dequeueFooter<T: UICollectionReusableView>(_: T.Type, for indexPath: IndexPath) -> T {
        guard
            let cell = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: String(describing: T.self), for: indexPath) as? T
        
        else { fatalError("Could not deque cell with type \(T.self)") }
        
        return cell
    }
    
    func registerHeader<T: UICollectionReusableView>(_: T.Type, reuseIdentifier: String? = nil) {
        let nib = UINib(nibName: reuseIdentifier ?? String(describing: T.self), bundle: nil)
        
        self.register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: reuseIdentifier ?? String(describing: T.self))
    }
    
    func dequeueHeader<T: UICollectionReusableView>(_: T.Type, for indexPath: IndexPath) -> T {
        guard
            let cell = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: T.self), for: indexPath) as? T
        
        else { fatalError("Could not deque cell with type \(T.self)") }
        
        return cell
    }
}

//INSTANTIATE STORYBOARD
extension UIStoryboard {
    func instantiate<T: UIViewController>(_ : T.Type, identifier: String? = nil) -> T {
        return self.instantiateViewController(withIdentifier: identifier ?? String(describing: T.self)) as! T
    }
}

//URL
extension URL {
    func valueOf(_ queryParameterName: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParameterName })?.value
    }
}

//STRING
extension String {
    var trim: String {
        return self.trimmingCharacters(in: .whitespaces)
    }
}
