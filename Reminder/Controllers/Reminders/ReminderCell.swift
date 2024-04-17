//
//  ReminderCell.swift
//  Reminder
//
//  Created by Türker Kızılcık on 8.02.2024.
//

import UIKit

class ReminderCell: UITableViewCell {
    // MARK: Stack Views
    let titleHorizontalView : UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.distribution = .fillEqually
        view.axis = .vertical
        view.spacing = 4
        return view
    }()

    let infoHorizontalView : UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.distribution = .fillEqually
        view.axis = .vertical
        view.alignment = .trailing
        view.spacing = 4
        return view
    }()
    // MARK: Labels
    let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let subtitleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.placeholderText
        return label
    }()

    let dateLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let timeLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // MARK: Buttons & Actions
    let checkBoxButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.tintColor = UIColor.placeholderText
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        return button
    }()

    var checkBoxAction: (() -> Void)? // TODO: why cant this be let

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstraints()
        checkBoxButton.addTarget(self, action: #selector(checkBoxTapped), for: .touchUpInside)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(reminder: Reminder) {
        titleLabel.text = reminder.title
        titleLabel.accessibilityLabel = "\("title".localized()): \(reminder.title)"

        subtitleLabel.text = reminder.description
        subtitleLabel.accessibilityLabel = "\("description".localized()): \(reminder.description)"

        dateLabel.text = reminder.date
        dateLabel.accessibilityLabel = "\("date".localized()): \(reminder.date)"

        timeLabel.text = reminder.time
        timeLabel.accessibilityLabel = "\("time".localized()): \(reminder.time)"
    }
    
    // MARK: View Functions
    private func addSubviews() {
        contentView.addSubview(infoHorizontalView)
        contentView.addSubview(titleHorizontalView)
        contentView.addSubview(checkBoxButton)

        titleHorizontalView.addArrangedSubview(titleLabel)
        titleHorizontalView.addArrangedSubview(subtitleLabel)

        infoHorizontalView.addArrangedSubview(dateLabel)
        infoHorizontalView.addArrangedSubview(timeLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            checkBoxButton.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            checkBoxButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            checkBoxButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            checkBoxButton.widthAnchor.constraint(equalToConstant: 28),

            titleHorizontalView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleHorizontalView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            titleHorizontalView.trailingAnchor.constraint(equalTo: infoHorizontalView.leadingAnchor, constant: -8),
            titleHorizontalView.leadingAnchor.constraint(equalTo: checkBoxButton.trailingAnchor, constant: 8),

            infoHorizontalView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.3),
            infoHorizontalView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            infoHorizontalView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            infoHorizontalView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }

    // MARK: @Objc Functions

    @objc private func checkBoxTapped() {
        checkBoxButton.setImage(UIImage(systemName: "circle.inset.filled"), for: .normal)
        checkBoxButton.tintColor = UIColor.systemOrange
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.checkBoxAction?()
            self.checkBoxButton.setImage(UIImage(systemName: "circle"), for: .normal)
            self.checkBoxButton.tintColor = UIColor.placeholderText
        }
    }
}
