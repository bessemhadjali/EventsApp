//
//  AddEventViewController.swift
//  EventsApp
//
//  Created by Bessem Hadj Ali on 13/10/2020.
//

import UIKit

class AddEventViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var addEventViewModel: AddEventViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        addEventViewModel.viewDidLoad { [weak self] in
            self?.tableView.reloadData()
        }
        
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        addEventViewModel.viewDidDisapear()
    }
    
    func setupView() {
        // Table View
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        //        tableView.rowHeight = UITableView.automaticDimension
        //        tableView.estimatedRowHeight = 600
        tableView.separatorColor = .clear
        // Force large title
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.setContentOffset(.init(x: 0, y: -1), animated: false)
        
        // Navigation Item
        navigationItem.title = addEventViewModel.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tappedDone))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(tappedCancel))
        
        // Navigation Bar
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black
    }
    
    @objc func tappedDone() {
        addEventViewModel.tappedDone()
    }
    
    @objc func tappedCancel() {
        addEventViewModel.tappedCancel()
    }
    
}

extension AddEventViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addEventViewModel.numberOfRow()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellViewModel = addEventViewModel.cell(for: indexPath)
        switch cellViewModel {
        case .titleSubTitle(let titleSubtitleVM):
            let cell = tableView.dequeueReusableCell(withIdentifier: "titleSubtitleCell", for: indexPath) as! TitleSubTitleTableViewCell
            //print("subtitle: \(titleSubtitleVM.subtitle) for indexPath: \(indexPath.row)")
            cell.update(with: titleSubtitleVM)
            cell.textField.delegate = self
            return cell
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.addEventViewModel.didSelectRow(at: indexPath)
    }
    
}

extension AddEventViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return false }
        let text = currentText + string
        
        
        let point = textField.convert(textField.bounds.origin, to: tableView)
        if let indexPath = tableView.indexPathForRow(at: point) {
            
            addEventViewModel.updateCell(indewPath: indexPath, subtitle: text)
        }
        return true
    }
}
