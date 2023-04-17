//
//  WASearchResultsViewController.swift
//  WeatherApp
//
//  Created by Chirag on 4/16/23.
//

import Foundation
import UIKit


protocol SearchResultsDelegate: AnyObject {
    // Update Weather Table with model
    func showWeather(forLocation: Location)
}


class SearchResultsViewController: UITableViewController, UISearchResultsUpdating, SearchResultsPresenterDelegate {
    
    weak var delegate : SearchResultsDelegate?

    var locations = [Location]()
    private let presenter = SearchResultsPresenter()
    private let weatherVCpresenter = WeatherViewControllerPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        let location = locations[indexPath.row]
        var displayString = location.name
        if let state = location.state {
            displayString.append(", \(state),")
        }
        displayString.append(" \(location.country)")
        
        cell?.textLabel?.text = displayString
        cell?.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        return cell!
    }
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = locations[indexPath.row]
        self.dismiss(animated: true) { [self] in
            delegate?.showWeather(forLocation: location)
        }
    }
    
    /// UISearchResultUpdating
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        //search only after user enters more than 2 characters
        if(text.count>2) {
            presenter.getLocations(city: text)
        }
    }
    
    ///Presenter Delegate
    func updateWithLocations(response: [Location]) {
        locations = response
        DispatchQueue.main.async {            
            self.tableView.reloadData()
        }
    }

    
}
