//
//  BaseDatabaseResult.swift
//  Movie
//
//  Created by pham.xuan.tien on 1/24/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

import Foundation

enum BaseDBResult {
    case success()
    case failure(error: NSError?)
}
