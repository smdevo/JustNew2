//
//  MainViewController.swift
//  JustNew2
//
//  Created by Samandar on 23/06/24.
//

import UIKit

class MainViewController: UIViewController {
    

    
//MARK: Properties
    
    let tableView = UITableView()
    
    var people: [Person]?
    
    let mcontext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    

//MARK: func override
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //fetchData
        fetchData()
        
        //setting defaultView
        settingdefaultView()
      

        // Set up table view
        settingTableView()
        
       
        
    }//viewDidLoad
    
    
    
    //MARK: Functions
    
    func fetchData() {
        
        do {
           try people = mcontext.fetch(Person.fetchRequest())
        }
        catch {
            
        }
        
        //reloadTableView
        tableView.reloadData()
    
    }//fetchData
    
    
    
    func settingdefaultView() {
        
        view.backgroundColor = .white
        
        navigationItem.title = "People"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addingaction))
        
        
    }//settingdefaultView
    
    
    func settingTableView() {
        
        // Set up table view
        tableView.dataSource = self
        tableView.delegate = self
        
        // Registering the custom cell
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "MainTableViewCell")
        
        self.view.addSubview(tableView)

        
        // Set up constraints
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
    }//settingTableView
    

    
    
    
    //MARK: Actions
    
    @objc func addingaction(){
        
        print("Added")
        
        let person = Person(context: mcontext)
        person.name = "Samandar"
        person.age = 20
        
        do {
            try mcontext.save()
        }catch {
            
        }
        
        fetchData()
        
    }//addingaction
    
   
}//MainVC



extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people?.count ?? 5 // Number of rows in the section
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? MainTableViewCell else {
            return UITableViewCell()
        }
        
        guard let person = people?[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.nameLabel.text = person.name ?? "Unknown"
        cell.ageLabel.text = String(person.age)
        
        //cell.textLabel?.text = "Row \(indexPath.row)"
        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row at index \(indexPath.row)")
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
            if editingStyle == .delete {
                
                
                guard let person = people?[indexPath.row] else {
                    return
                }
                
                mcontext.delete(person)
                
                do {
                    try mcontext.save()
                }
                catch {
                    
                }
                fetchData()
                
            }
        }
    
    

    
}
