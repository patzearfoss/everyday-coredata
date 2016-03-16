//
//  main.swift
//  CodersOnly
//
//  Created by Patrick Zearfoss on 3/16/16.
//  Copyright © 2016 PatZearfoss. All rights reserved.
//

import Foundation
import UIKit

func isRunningTests() -> Bool {
    let environment = NSProcessInfo.processInfo().environment
    if let injectBundle = environment["XCInjectBundle"] {
        let nsInjectBundle:NSString = injectBundle
        return nsInjectBundle.pathExtension == "xctest"
    }
    return false
}


class UnitTestsAppDelegate: UIResponder, UIApplicationDelegate
{
    
}

if isRunningTests() {
    UIApplicationMain(Process.argc, Process.unsafeArgv, NSStringFromClass(UIApplication), NSStringFromClass(TestAppDelegate))
}else{
    UIApplicationMain(Process.argc, Process.unsafeArgv, NSStringFromClass(UIApplication), NSStringFromClass(AppDelegate))
}
