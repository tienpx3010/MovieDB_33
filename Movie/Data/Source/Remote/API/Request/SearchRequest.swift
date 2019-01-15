//
//  SearchRequest.swift
//  Movie
//
//  Created by pham.xuan.tien on 1/9/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

import Foundation

final class SearchRequest: BaseRequest {
    required init(text: String, page: Int) {
        let body: [String: Any] = [
            "query": text,
            "page": page
        ]
        super.init(url: URLs.APISearchURL, requestType: .get, body: body)
    }
}
