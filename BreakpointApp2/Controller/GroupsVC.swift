//
//  SecondViewController.swift
//  BreakpointApp2
//
//  Created by Fred Lefevre on 2019-10-23.
//  Copyright © 2019 Fred Lefevre. All rights reserved.
//

import UIKit

class GroupsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }


}

extension GroupsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell") as? GroupCell else {
            return UITableViewCell()
        }
        cell.configureCell(title: "Le group a Joe", description: "Joe Mambre", membersCount: 3)
        return cell
    }
    
    
}
