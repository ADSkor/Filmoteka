//
//  XibView.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import UIKit

open class XibView: UIView {
    // MARK: - Initialize

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fromNib()
    }

    public init() {
        super.init(frame: CGRect.zero)
        fromNib()
        loadedFromNibProgramatically()
    }

    open func loadedFromNibProgramatically() {}

    open func module() -> Bool { return false }

    func fromNibWithoutConstraints() -> UIView? {
        if module() {
            guard let contentView = Bundle.module.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? UIView else { return nil }

            contentView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(contentView)

            return contentView
        }
        else {
            guard let contentView = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? UIView else {
                return nil
            }

            contentView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(contentView)

            return contentView
        }
    }

    @discardableResult func fromNib() -> UIView? {
        guard let contentView = fromNibWithoutConstraints() else { return nil }

        let bottomConstraint = NSLayoutConstraint(
            item: contentView,
            attribute: NSLayoutConstraint.Attribute.bottom,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: self,
            attribute: NSLayoutConstraint.Attribute.bottom,
            multiplier: 1,
            constant: 0
        )

        let trailingConstraint = NSLayoutConstraint(
            item: contentView,
            attribute: NSLayoutConstraint.Attribute.trailing,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: self,
            attribute: NSLayoutConstraint.Attribute.trailing,
            multiplier: 1,
            constant: 0
        )

        let topConstraint = NSLayoutConstraint(
            item: contentView,
            attribute: NSLayoutConstraint.Attribute.top,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: self,
            attribute: NSLayoutConstraint.Attribute.top,
            multiplier: 1,
            constant: 0
        )

        let leadingConstraint = NSLayoutConstraint(
            item: contentView,
            attribute: NSLayoutConstraint.Attribute.leading,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: self,
            attribute: NSLayoutConstraint.Attribute.leading,
            multiplier: 1,
            constant: 0
        )

        addConstraints([bottomConstraint, trailingConstraint, topConstraint, leadingConstraint])

        return contentView
    }
}
