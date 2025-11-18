//
//  Dropdown.swift
//  DropdownLibrary
//
//  Created by enjay on 18/11/25.
//
import UIKit

public class Dropdown: UIView, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Public Properties
    public var anchorView: UIView?
    public var dataSource: [String] = []
    public var selectionAction: ((Int, String) -> Void)?

    // MARK: - Private Properties
    private let tableView = UITableView()

    // MARK: - Initializers
    public init() {
        super.init(frame: .zero)
        setupUI()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    // MARK: - UI Setup
    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self

        let nib = UINib(
            nibName: "DropdownCell",
            bundle: Bundle.module
        )
        tableView.register(nib, forCellReuseIdentifier: "DropdownCell")

        tableView.layer.cornerRadius = 8
        tableView.clipsToBounds = true

        tableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }

    // MARK: - Public Methods
    public func show() {
        guard let anchor = anchorView, let parent = anchor.superview else {
            print("Dropdown Error: anchorView not set or has no superview")
            return
        }

        // Calculate dropdown frame
        let height = min(CGFloat(dataSource.count) * 44, 200)

        self.frame = CGRect(
            x: anchor.frame.minX,
            y: anchor.frame.maxY + 4,
            width: anchor.frame.width,
            height: height
        )

        parent.addSubview(self)
        self.tableView.reloadData()
    }

    public func hide() {
        self.removeFromSuperview()
    }

    // MARK: - TableView Methods
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    public func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        let cell = tableView
            .dequeueReusableCell(withIdentifier: "DropdownCell", for: indexPath) as! DropdownCell

        cell.titleLabel.text = dataSource[indexPath.row]
        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectionAction?(indexPath.row, dataSource[indexPath.row])
        hide()
    }
}




