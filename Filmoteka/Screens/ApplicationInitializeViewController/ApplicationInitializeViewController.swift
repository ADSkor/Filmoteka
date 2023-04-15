//
//  ApplicationInitializeViewController.swift
//  Filmoteka
//
//  Created by Aleksandr Skorotkin on 15.04.2023.
//

import UIKit
import Miji
import SDWebImage

class ApplicationInitializeViewController: CustomViewController {
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView?
    @IBOutlet private weak var loadingTextLabel: UILabel?

    private var context: Context?
    private var sendPopToRootViewControllerObserver: Any?
    private weak var searchViewController: UIViewController?

    @IBAction private func didTap(button _: UIButton?) {
        #if DEBUG
        debugPrint("We can use it for debug session...")
        #endif
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorView?.start()
        proceed()
    }

    private func proceed() {
        let context = Context()
        self.context = context
        context.initialize()
        
        let searchViewController = SearchScreenViewController.fromStoryboard(
            context: context,
            searchText: ""
        )
        
        self.searchViewController = searchViewController
        var viewControllers = navigationController?.viewControllers ?? []
        let animated = viewControllers.count > 1 ? false : true // replace without animation
        viewControllers = [self, searchViewController]
        navigationController?.setViewControllers(viewControllers, animated: animated)
    }

    private func dismissAll() {
        popTo(self, animated: true)
        navigationController?.dismiss(animated: true, completion: nil)
    }
}
