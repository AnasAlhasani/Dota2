//
//  SideMenuViewController.swift
//  Dota2
//
//  Created by Anas Alhasani on 11/4/17.
//  Copyright © 2017 Anas Alhasani. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet private weak var tableView: UITableView!
    
    //MARK: Properties
    private let services: [Service] = [
        .dashboard,
        .heroes,
        .items
    ]
    
    //MARK: View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}



//MARK: - UITableViewDataSource
extension SideMenuViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuCell", for: indexPath) as? SideMenuCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        let service = services[indexPath.row]
        cell.serviceTitle = service.title
        cell.imageName = service.imageName
        return cell
    }
}

//MARK: - UITableViewDelegate
extension SideMenuViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let service = services[indexPath.row]
        navigateTo(viewController: service.controller, segueType: .sideMenuContent)
    }
}


//MARK: - Constants
private extension SideMenuViewController {
    
    enum Service {
        case dashboard
        case heroes
        case items
        
        var imageName: String {
            switch self {
            case .dashboard: return "DashboardIcon"
            case .items: return "DashboardIcon"
            case .heroes: return "DashboardIcon"
            }
        }
        
        var title: String {
            switch self {
            case .dashboard: return "Dashboard"
            case .items: return "Items"
            case .heroes: return "Heroes"
            }
        }
        
        var controller: UIViewController.Type {
            switch self {
            case .dashboard: return DashboardViewController.self
            case .items: return DashboardViewController.self
            case .heroes: return HeroesViewController.self
            }
        }
    }
    
}

