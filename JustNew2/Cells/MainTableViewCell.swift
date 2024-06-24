//
//  MainTableViewCell.swift
//  JustNew2
//
//  Created by Samandar on 23/06/24.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let ageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }

    private func setupCell() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(ageLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                       nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                       nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
                       
                       // Age label constraints
                       ageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                       ageLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                       ageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
                       
                       // Ensuring the labels don't overlap
                       nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: ageLabel.leadingAnchor, constant: -8)
        ])
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
