//
//  File.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import Foundation

enum DebugInfo {
    static func alert(
        title: String,
        message: String? = nil,
        okButtonTitle: String = "OK",
        noButtonTitle: String? = nil
    ) -> String {
        let output = StringsCombiner(separator: "\n\n\t\t")
            .append("---ALERT STARTED---")
            .append("Title:")
            .append(title)
            .append("Message:")
            .append(message)
            .append("OK Button Title:")
            .append(okButtonTitle)
            .append("No Button Title:")
            .append(noButtonTitle)
            .append("---ALERT ENDED---")
            .toString()

        return output
    }

    static func prompt(
        title: String,
        message: String? = nil,
        yesButtonTitle: String,
        noButtonTitle: String
    ) -> String {
        let output = StringsCombiner(separator: "\n\n\t\t")
            .append("---PROMPT STARTED---")
            .append("Title:")
            .append(title)
            .append("Message:")
            .append(message)
            .append("Yes Button Title:")
            .append(yesButtonTitle)
            .append("No Button Title:")
            .append(noButtonTitle)
            .append("---PROMPT ENDED---")
            .toString()

        return output
    }
}
