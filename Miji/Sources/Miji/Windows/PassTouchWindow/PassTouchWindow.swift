//
//  PassTouchView.swift
//  AnyApp
//
//  Created by Aleksandr Skorotkin on 09.01.2023.
//  Copyright © 2022 ADSkor. All rights reserved.
//

import UIKit

public class PassTouchWindow: UIWindow {
    override public func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)

        if view?.superview == self {
            return nil
        }
        else if let dogTagged = view as? DogTaggedView,
                dogTagged.dogTag == DogTaggedView.passTouchTag
        {
            return nil
        }

        return view
    }
}
