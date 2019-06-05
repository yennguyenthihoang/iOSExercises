//
//  ViewController.swift
//  UserList
//
//  Created by epita on 05/06/2019.
//  Copyright © 2019 epita. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {

    var userArray: [RandomUser]?
    var results: UserBase?
    @IBOutlet weak var usersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUsers()
    }
    func fetchUsers(){
        var request = URLRequest(url: URL(string: "https://randomuser.me/api/?results=10")!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: {data, response, error -> Void
            in
            do{
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode(UserBase.self, from: data!)
                
                self.userArray = responseModel.results
                DispatchQueue.main.async {
                    self.usersTableView.reloadData()
                }
            } catch let error {
                print("JSON Serialization error: ", error)
            }
        }).resume()
    }

    func formatName(userName: UserName) -> String {
        return userName.title.capitalized + " " + userName.first.capitalized + " " + userName.last.capitalized
    }
}

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = usersTableView.dequeueReusableCell(withIdentifier: "user") else {
            return UITableViewCell()
        }
        if let user = userArray?[indexPath.row]{
            let fullName = formatName(userName: user.name)
            cell.textLabel?.text = fullName
        }
        return cell
    }
}


