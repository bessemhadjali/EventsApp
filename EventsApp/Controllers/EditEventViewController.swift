//
//  EditEventViewController.swift
//  EventsApp
//
//  Created by Bessem Hadj Ali on 20/10/2020.
//

import UIKit

class EditEventViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var editEventViewModel: EditEventViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        editEventViewModel.viewDidLoad { [weak self] in
            self?.tableView.reloadData()
        }
    }
    

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        editEventViewModel?.viewDidDisapear()
    }
    
    func setupView() {
        // Table View
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.separatorColor = .clear
        // Force large title
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.setContentOffset(.init(x: 0, y: -1), animated: false)
        
        // Navigation Item
        navigationItem.title = editEventViewModel.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tappedDone))
                
        // Navigation Bar
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black
    }
    
    @objc func tappedDone() {
        editEventViewModel.tappedDone()
    }

}

extension EditEventViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return editEventViewModel.numberOfRow()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellViewModel = editEventViewModel.cell(for: indexPath)
        switch cellViewModel {
        case .titleSubTitle(let titleSubtitleVM):
            let cell = tableView.dequeueReusableCell(withIdentifier: "titleSubtitleCell", for: indexPath) as! TitleSubTitleTableViewCell
            cell.update(with: titleSubtitleVM)
            cell.textField.delegate = self
            return cell
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.editEventViewModel.didSelectRow(at: indexPath)
    }
    
}

extension EditEventViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return false }
        let text = currentText + string
        
        
        let point = textField.convert(textField.bounds.origin, to: tableView)
        if let indexPath = tableView.indexPathForRow(at: point) {
            
            editEventViewModel.updateCell(indewPath: indexPath, subtitle: text)
        }
        return true
    }
}
