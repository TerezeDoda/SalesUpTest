//
//  GlobalDispatch.swift
//  SalesUpApp
//
//  Created by ritech on 14.3.22.
//

import Foundation

func dispatchToMain(_ block: @escaping () -> Void) {
    if Foundation.Thread.isMainThread {
        block()
    } else {
        DispatchQueue.main.async(execute: block)
    }
}

func dispatchToMain(after interval: TimeInterval, _ block: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + interval, execute: block)
}

func dispatchTo(_ qos: DispatchQoS.QoSClass, _ block: @escaping () -> Void) {
    DispatchQueue.global(qos: qos).async(execute: block)
}
