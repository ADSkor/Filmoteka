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
                animatedPresentation = true
    
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
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupToHideKeyboardOnTapOnView()
        unlockInterface()
        statusBarView?.backgroundColor = .blue.withAlphaComponent(0.3)

        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .white

        guard let appContext else { return }
        dataFetcher = SearchScreenDataFetcher(
            appContext: appContext,
            delegate: self
        )
        
        searchTextFieldView?.delegate = self
        searchTextFieldView?.setFocus()
        searchTextFieldView?.set(text: searchText)

        searchResultsView?.delegate = self
        noResultsView?.delegate = self

        set(state: .specifyingSearchRequest)
    }

    private func blockInterfaceWhileLoading() {
        interfaceBlockingView?.show()
    }

    private func unlockInterface() {
        interfaceBlockingView?.hide()
    }

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
        guard searchText != previousSearchText else { return }
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
        case .specifyingSearchRequest:
            searchResultsView?.isHidden = true
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
        searchText = text
        performSearchText()
    }
}

extension SearchScreenViewController: SearchScreenDataFetcherDelegate {
    func searchScreenDataFetcher(_ fetcher: SearchScreenDataFetcher, didFetch fullFilmsInfo: FullFilmsInfo) {
        
        guard state == .fetching else { return }
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
        debugPrint(film.id)
    }
    
    func searchScreenResultsViewDidTap(_ view: SearchScreenResultsView, didPressFavorite film: Film) {
        debugPrint(film.id)
    }
    
    //MARK: - Paging
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
