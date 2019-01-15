//
//  Throttler.swift
//  Movie
//
//  Created by pham.xuan.tien on 1/9/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

import UIKit
import Foundation

class Throttler {
    private let queue: DispatchQueue = DispatchQueue.global(qos: .background)
    private var job: DispatchWorkItem = DispatchWorkItem(block: {})
    private var previousRun: Date = Date.distantPast
    private var maxInterval: Int

    init(seconds: Int) {
        self.maxInterval = seconds
    }

    func throttle(block: @escaping () -> Void) {
        job.cancel()
        job = DispatchWorkItem(block: { [weak self] in
            guard let self = self else { return }
            self.previousRun = Date()
            block()
        })
        let delay = Date.second(from: previousRun) > maxInterval ? 0 : maxInterval
        queue.asyncAfter(deadline: .now() + Double(delay), execute: job)
    }
}
