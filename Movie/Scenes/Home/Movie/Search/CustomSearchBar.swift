//
//  CustomSearchBar.swift
//  Movie
//
//  Created by pham.xuan.tien on 1/9/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

import Foundation
import UIKit

protocol CustomSearchBarDelegate: NSObjectProtocol {
    func customSearchBarCancelButtonClicked()
    func customSearchBar(textDidChange searchText: String)
    func customSearchBarSearchButtonClicked(searchText: String)
    func customSearchBar(textWillChange searchText: String)
}

class CustomSearchBar: UISearchBar {
    private var throttler = Throttler(seconds: 0)
    weak var customDelegate: CustomSearchBarDelegate?
    var throttlingInterval: Int = 0 {
        didSet {
            self.throttler = Throttler(seconds: throttlingInterval)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        setShowsCancelButton(true, animated: true)
    }
}

extension CustomSearchBar: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        customDelegate?.customSearchBarCancelButtonClicked()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = text else {
            return
        }
        customDelegate?.customSearchBarSearchButtonClicked(searchText: text)
        resignFirstResponder()
        if let cancelButton = value(forKey: "_cancelButton") as? UIButton {
            cancelButton.isEnabled = true
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            return
        }
        customDelegate?.customSearchBar(textWillChange: searchText)
        throttler.throttle {
            DispatchQueue.main.async {
                self.customDelegate?.customSearchBar(textDidChange: searchText)
            }
        }
    }
}
