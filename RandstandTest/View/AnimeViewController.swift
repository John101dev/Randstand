//
//  AnimeViewController.swift
//  RandstandTest
//
//  Created by 愤怒大葱鸭 on 1/14/21.
//  Copyright © 2021 Randstand. All rights reserved.
//

import UIKit
import WebKit
import SwiftUI

class AnimeViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let loadingIndicator = UIActivityIndicatorView(style: .large)
    let cellId = "AnimeCell"
    var viewModel: AnimeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel = AnimeViewModel(urlStr: Constant.url)
        tblView.delegate = self
        tblView.dataSource = self
        searchBar.delegate = self
        viewModel.getData()
        viewModel.delegate = self
        tblView.register(UINib(nibName: "AnimeTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
    }

    func setupUI() {
        loadingIndicator.center = self.view.center
        loadingIndicator.startAnimating()
        loadingIndicator.hidesWhenStopped = true
        self.view.addSubview(loadingIndicator)
        tblView.rowHeight = UITableView.automaticDimension
        tblView.estimatedRowHeight = 100
        tblView.keyboardDismissMode = .onDrag
    }

    /// - Parameter urlStr: the url for website
    func presentWeb(urlStr: String) {
        let vc = UIHostingController(rootView: WebView(urlStr: urlStr))
        self.present(vc, animated: true, completion: nil)
    }
}

// MARK: -Table view
extension AnimeViewController: UITableViewDelegate, UITableViewDataSource, AnimeDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let animes = viewModel.filteredAnimes {
            return animes.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? AnimeTableViewCell else {
            return UITableViewCell()
        }
        if let animes = viewModel.filteredAnimes {
            cell.anime = animes[indexPath.row]
            cell.bindAnime()
            cell.layoutIfNeeded()
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let urlStr = viewModel.animes?[indexPath.row].url {
            presentWeb(urlStr: urlStr)
        }
    }

    func refreshTableView() {
        DispatchQueue.main.async {
            self.loadingIndicator.stopAnimating()
            self.tblView.reloadData()
        }
    }
}

// MARK: -Search bar
extension AnimeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filteredAnimes = searchText.isEmpty ? viewModel.animes : viewModel.animes?.filter({ (anime: MOBAnime) -> Bool in
            return anime.url?.contains(searchText) ?? false
        })
        tblView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
}
