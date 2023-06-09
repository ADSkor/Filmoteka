//
//  ApplicationInitializeViewController.swift
//  Filmoteka
//
//  Created by Aleksandr Skorotkin on 15.04.2023.
//

import UIKit
import Miji
import SDWebImage

//This controller for handle which controller we give next
class ApplicationInitializeViewController: CustomViewController {
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView?
    @IBOutlet private weak var loadingTextLabel: UILabel?

    private var appContext: AppContext?
    private var sendPopToRootViewControllerObserver: Any?
    private weak var searchViewController: UIViewController?

    //Button if you need something to do while you waiting for loading
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
        let appContext = AppContext()
        self.appContext = appContext
        appContext.initialize()
        
        let searchViewController = SearchScreenViewController.fromStoryboard(
            appContext: appContext,
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
