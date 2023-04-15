//
//  Threads.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import Foundation

public func main(work: @escaping () -> Void) {
    DispatchQueue.main.async {
        work()
    }
}

public func main(delay: Double, work: @escaping () -> Void) {
    let deadline = DispatchTime.now() + delay
    DispatchQueue.main.asyncAfter(deadline: deadline) {
        work()
    }
}

public func userInteractive(delay: Double, work: @escaping () -> Void) {
    let deadline = DispatchTime.now() + delay
    DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: deadline) {
        work()
    }
}

public func userInteractive(work: @escaping () -> Void) {
    DispatchQueue.global(qos: .userInteractive).async {
        work()
    }
}

public func userInitiated(delay: Double, work: @escaping () -> Void) {
    let deadline = DispatchTime.now() + delay
    DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: deadline) {
        work()
    }
}

public func userInitiated(work: @escaping () -> Void) {
    DispatchQueue.global(qos: .userInitiated).async {
        work()
    }
}

public func utility(delay: Double, work: @escaping () -> Void) {
    let deadline = DispatchTime.now() + delay
    DispatchQueue.global(qos: .utility).asyncAfter(deadline: deadline) {
        work()
    }
}

public func utility(work: @escaping () -> Void) {
    DispatchQueue.global(qos: .utility).async {
        work()
    }
}

public func background(delay: Double, work: @escaping () -> Void) {
    let deadline = DispatchTime.now() + delay
    DispatchQueue.global(qos: .background).asyncAfter(deadline: deadline) {
        work()
    }
}

public func background(work: @escaping () -> Void) {
    DispatchQueue.global(qos: .background).async {
        work()
    }
}
