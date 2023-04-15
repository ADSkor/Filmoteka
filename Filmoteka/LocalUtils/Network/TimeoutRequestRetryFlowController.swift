//
//  TimeoutRequestRetryFlowController.swift
//  Filmoteka
//
//  Created by Aleksandr Skorotkin on 15.04.2023.
//

import Alamofire
import Miji
import SwiftyJSON
import UIKit

class TimeoutRequestRetryFlowController {
    static func performGetIfCan(
        address: String,
        headers: Alamofire.HTTPHeaders,
        shouldHandleErrors: Bool,
        shouldRefreshToken: Bool,
        session: Session = AF,
        completion: ((JSON?, Error?, Int?) -> Void)?
    ) {
        guard let viewController = KeyWindow?.rootViewController?.visibleViewController else {
            Self.performTimeoutResult(completion: completion)
            return
        }
        viewController.prompt(
            title: "Failed to download the data, want to try again?",
            yesBlock: {
                Network.shared.get(
                    address: address,
                    headers: headers,
                    shouldHandleErrors: shouldHandleErrors,
                    shouldHandleTimeout: true,
                    shouldRefreshToken: shouldRefreshToken,
                    session: session,
                    completion: completion
                )
            },
            noBlock: {
                Self.performTimeoutResult(completion: completion)
            }
        )
    }

    static func performTimeoutResult(completion: ((JSON?, Error?, Int?) -> Void)?) {
        completion?(
            nil,
            NSError.error(
                code: NSURLErrorTimedOut,
                localizedDescription: "Exceeded waiting for reply from server, try again later."
            ),
            NSURLErrorTimedOut
        )
    }
}
