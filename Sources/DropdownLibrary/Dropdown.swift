//
//  Dropdown.swift
//  DropdownLibrary
//
//  Created by enjay on 18/11/25.
//


import UIKit

public class Dropdown: UIView, UITableViewDelegate, UITableViewDataSource {

    private var items: [String] = []
    private var onSelect: ((String) -> Void)?
    private let tableView = UITableView()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self

        let nib = UINib(
            nibName: "DropdownCell",
            bundle: Bundle.module
        )

        tableView.register(nib, forCellReuseIdentifier: "DropdownCell")

        tableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }

    public func setItems(_ data: [String], onSelect: @escaping (String) -> Void) {
        self.items = data
        self.onSelect = onSelect
        tableView.reloadData()
    }

    // MARK: TableView
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    public func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "DropdownCell", for: indexPath) as! DropdownCell
        cell.titleLabel.text = items[indexPath.row]
        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onSelect?(items[indexPath.row])
    }
}


//import UIKit
//
//class Dropdown: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
//
//
//
//}
