//
//  SearchScreenViewController.swift
//  Filmoteka
//
//  Created by Aleksandr Skorotkin on 15.04.2023.
//

import Foundation
import UIKit
import Miji
import SwiftyJSON
import SwiftUI

    //All ViewControllers in UIKit are based on TableView. Thanks to this we can expand any ViewController with cells without having to change the ViewController itself
class SearchScreenViewController: CustomViewController {

    @IBOutlet private weak var searchTextFieldView: SearchScreenTextFieldView?
    @IBOutlet private weak var searchResultsView: SearchScreenResultsView?
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView?
    @IBOutlet private weak var noResultsView: SearchScreenNoResultsView?
    @IBOutlet private weak var statusBarView: UIView?
    @IBOutlet private weak var interfaceBlockingView: UIView?

    private let network = Network.shared
    
    private var films: [Film]? {
                    didSet {
                        reloadData()
                    }
                }
    //We need var's because we need to change the ViewControllers when we get them from 'fromStoryboard' method. It doesn't increase memory, as we might have thought. In basic applications I keep track with WatchDog, which I created with a colleague of mine a couple of years ago
    private var appContext: AppContext?,
                state: SearchScreenViewControllerState = .noResults,
                searchText = "",
                previousSearchText = "",
                requestedPage = 1,
                lastPage = 1,
                tableViewAdapter: TableViewAdapter?,
                dataFetcher: SearchScreenDataFetcher?,
                runSearchOnStart = false,
                observer: Any?,
                animatedPresentation = true,
                itIsFirstAppearance = true
    
    //To create that ViewController anywhere and call it
    static func fromStoryboard(
        appContext: AppContext,
        searchText: String,
        animatedPresentation: Bool = true
    ) -> UIViewController {
        let viewController: SearchScreenViewController = .fromStoryboard()
        viewController.appContext = appContext
        viewController.searchText = searchText
        viewController.animatedPresentation = animatedPresentation
        return viewController
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        //FirstAppearance avoid
        if !itIsFirstAppearance {
            reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //Preparations
        setupToHideKeyboardOnTapOnView()
        unlockInterface()
        statusBarView?.backgroundColor = .white

        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .white

        //create and init SearchScreenDataFetcher
        guard let appContext else { return }
        dataFetcher = SearchScreenDataFetcher(
            appContext: appContext,
            delegate: self
        )
        
        //take all needed delegates
        searchTextFieldView?.delegate = self
        searchResultsView?.delegate = self
        noResultsView?.delegate = self
        //set focus on search field for user
        searchTextFieldView?.set(text: searchText)
        searchTextFieldView?.setFocus()
        //set state that means user start typing
        set(state: .specifyingSearchRequest)
    }

    private func blockInterfaceWhileLoading() {
        interfaceBlockingView?.show()
    }

    private func unlockInterface() {
        interfaceBlockingView?.hide()
    }

    //Reload cells, for update whole view, without ios glitch which heppends when you trying to update only your cell in tableView
    func reloadData() {
        searchResultsView?.set(
            films: films,
            resultsViewDelegate: self,
            appContext: appContext
        )
        
        set(state: .results)
    }

    private func performSearchText() {
        guard searchText.count > 0 else { return }
        guard searchText != previousSearchText else {
            searchTextFieldView?.shakeButton()
            return
        }
        previousSearchText = searchText
        
        films = []

        set(state: .fetching)
        
        requestedPage = 1
        dataFetcher?.fetch(endpointString: searchText.replacingOccurrences(of: " ", with: "+"))
    }
    
    private func startSearchWith(string: String) {
        searchTextFieldView?.set(text: string)
        searchText = string
        performSearchText()
    }

    private func set(state: SearchScreenViewControllerState) {
        self.state = state

        switch state {
            //not suree that we need it, when user starts typing new text
        case .specifyingSearchRequest:
            activityIndicatorView?.stop()
            noResultsView?.isHidden = true
            
        case .fetching:
            view.endEditing(true)
            searchResultsView?.isHidden = films?.count ?? 0 < 1
            activityIndicatorView?.start()
            noResultsView?.isHidden = true

        case .results:
            searchTextFieldView?.resignFocus()
            searchResultsView?.isHidden = false
            activityIndicatorView?.stop()
            noResultsView?.isHidden = true

        case .noResults:
            searchTextFieldView?.resignFocus()
            searchResultsView?.isHidden = true
            activityIndicatorView?.stop()
            noResultsView?.isHidden = false
            reloadNoResultView()
        }
    }

    //Helper for user when he's didn't get any of answers
    private func reloadNoResultView() {
        noResultsView?.set(
            searchText: searchText,
            examples: ["Pulp Fiction", "Matrix", "Crocodile Dundee"],
            delegate: self
        )
    }

    private func handleSearchTextDidChange(text: String) {
        //If wee need to check every single letter for something...
    }
}

extension SearchScreenViewController: SearchScreenTextFieldViewDelegate {
    func searchScreenTextFieldViewTextDidChange(_: SearchScreenTextFieldView, text: String) {
        handleSearchTextDidChange(text: text)
    }

    func searchScreenTextFieldViewDidBeginEditing(_: SearchScreenTextFieldView) {
        set(state: .specifyingSearchRequest)
    }

    func searchScreenTextFieldViewDidTapSearchButton(_: SearchScreenTextFieldView, text: String) {
        //Mock test from inside app in runTime
        guard text != "@flags" else {
            let flagsViewController = FlagsCheckboxesScreen.viewController()
            present(flagsViewController, animated: true)
            return
        }
        searchText = text
        performSearchText()
    }
}

extension SearchScreenViewController: SearchScreenDataFetcherDelegate {
    func searchScreenDataFetcher(_ fetcher: SearchScreenDataFetcher, didFetch fullFilmsInfo: FullFilmsInfo) {
        //checker that we can get more
        guard state == .fetching else { return }
        //just for check how much pages was downloaded
        debugPrint("page \(fullFilmsInfo.page) of \(fullFilmsInfo.total_pages) pages")
        lastPage = fullFilmsInfo.total_pages
        
        if self.films?.count ?? 0 < 1 {
            searchResultsView?.scrollToTop()
        }
        
        if previousSearchText == searchText {
            films?.append(contentsOf: fullFilmsInfo.results)
        } else {
            films = fullFilmsInfo.results
        }
        
        if self.films?.count ?? 0 < 1 {
            set(state: .noResults)
        }
        else {
            set(state: .results)
        }
    }
    
    //show errors
    func searchScreenDataFetcher(_ fetcher: SearchScreenDataFetcher, didFetch error: Error?) {
        guard let error else {
            showAlert(title: "'SearchScreenDataFetcher' did fetch Error, but can't recognize it like 'Error'")
            return
        }
        show(error) {
            self.set(state: .noResults)
        }
    }
}

extension SearchScreenViewController: SearchScreenResultsViewDelegate {
    func searchScreenResultsViewDidTap(_ view: SearchScreenResultsView, film: Film) {
        guard let appContext else { return }
        //SwiftUI calling from UIKit (Extra)
        let filmFullInfoView = FilmFullInfoView.viewController(film: film, mainAppContext: appContext)
        filmFullInfoView.modalPresentationStyle = .fullScreen
        push(filmFullInfoView, animated: true)
        itIsFirstAppearance = false
    }
    
    //MARK: - Favorites (Extra)
    func searchScreenResultsViewDidTap(_ view: SearchScreenResultsView, didPressFavorite film: Film) {
        guard let appContext else { return }
        if let index = appContext.favoritesMovies.firstIndex(where: { $0 == film.id }) {
            appContext.favoritesMovies.remove(at: index)
        } else {
            appContext.favoritesMovies.append(film.id)
        }
        UserDefaults.standard.set(appContext.favoritesMovies, forKey: "favoritesMovies")
        reloadData()
    }
    
    //MARK: - Paging (Extra)
    func searchScreenResultsViewDidReachBottom(_ view: SearchScreenResultsView) {
        guard state == .results else { return }
        if lastPage != requestedPage {
            requestedPage += 1
            set(state: .fetching)
            dataFetcher?.fetch(endpointString: "\(searchText.replacingOccurrences(of: " ", with: "+"))&page=\(requestedPage)")
        }
    }
}

extension SearchScreenViewController: SearchScreenNoResultsViewDelegate {
    func searchScreenNoResultsView(_ view: SearchScreenNoResultsView, didTapOn example: String) {
        startSearchWith(string: example)
    }
}
