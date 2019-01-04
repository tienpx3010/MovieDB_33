//
//  BaseRequest.swift
//  Movie
//
//  Created by pham.xuan.tien on 12/28/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import Alamofire

class BaseRequest: NSObject {
    var url = ""
    var requestType = Alamofire.HTTPMethod.get
    var body: [String: Any]?

    init(url: String) {
        super.init()
        self.url = url
    }

    init(url: String, requestType: Alamofire.HTTPMethod) {
        super.init()
        self.url = url
        self.requestType = requestType
    }

    init(url: String, requestType: Alamofire.HTTPMethod, body: [String: Any]?) {
        super.init()
        self.url = url
        self.requestType = requestType
        self.body = body
        self.body?.merge(dict: ["api_key": APIKey.key])
    }

    var encoding: ParameterEncoding {
        switch requestType {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
}
