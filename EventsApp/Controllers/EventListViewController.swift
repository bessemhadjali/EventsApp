//
//  EventListViewController.swift
//  EventsApp
//
//  Created by Bessem Hadj Ali on 11/10/2020.
//

import UIKit


class EventListViewController: UIViewController {
    
    var eventListVM: EventListViewModel!
    @IBOutlet weak var eventListTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        eventListVM.onUpdate = { [weak self] in
            self!.eventListTableView.reloadData()
        }
        
        eventListVM.loadCells()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    private func setupView() {
        let plusImage = UIImage(systemName: "plus.circle.fill")
        let barButtonItem = UIBarButtonItem(image: plusImage, style: .plain, target: self, action: #selector(tappedAddEventButton))
        let deleteButtonItem = UIBarButtonItem(title: "Delete All", style: .plain, target: self, action: #selector(tappedDeleteAllButton))
        barButtonItem.tintColor = .primary
        deleteButtonItem.tintColor = .primary
        navigationItem.rightBarButtonItem = barButtonItem
        navigationItem.leftBarButtonItem = deleteButtonItem
        navigationItem.title = eventListVM.title
        navigationController?.navigationBar.prefersLargeTitles = true
        
        eventListTableView.dataSource = self
        eventListTableView.delegate = self
        eventListTableView.tableFooterView = UIView()
    }
    
    @objc private func tappedAddEventButton() {
        eventListVM.tappedAddEvent()
    }
    
    @objc private func tappedDeleteAllButton() {
        eventListVM.tappedDeleteAllButton()
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}


extension EventListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventListVM.rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let eventCellvm = eventListVM.cell(for: indexPath)
        let eventCell = eventListTableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as! EventTableViewCell
        eventCell.update(with: eventCellvm)
        return eventCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        eventListVM.didSelectRow(at: indexPath)
    }
}
