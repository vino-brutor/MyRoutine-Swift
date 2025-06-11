//
//  CollectionViewCellTaskOfTheDay.swift
//  MinhaRotina
//
//  Created by Vítor Bruno on 06/06/25.
//

import UIKit

class CollectionViewCellTaskOfTheDay: UICollectionViewCell {
    
    static let identifier = "CollectionViewCellTaskOfTheDay"
    
    var onDeleteTapped: (() -> Void)?
    
    lazy var iconContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.backgroundColor = .cardLavanda
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.08
        view.layer.shadowRadius = 4
        view.layer.borderWidth = 1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        return view
    }()
    
    lazy var taskIcon: UIImageView = {
        let image = UIImageView()
        image.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        image.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var taskTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    lazy var taskTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 1
        label.textColor = .black
        return label
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func deleteTapped() {
        onDeleteTapped?()
    }
    
    lazy var stackViewLabels: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [taskTitleLabel, taskTimeLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .leading
        
        return stackView
    }()

    lazy var stackViewCell: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [iconContainerView, stackViewLabels])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 16
        return stackView
    }()
    
    func config(with task:Task) {
        taskTitleLabel.text = task.title
        taskTimeLabel.text = formateTime(task.time ?? Date())
        var taskIconImage: UIImage = UIImage()
        
        if let icon = taskIcons.first(where: { $0.name == task.iconName }) {
            taskIcon.image = icon.icon
        }

          
        if let matchedColor = taskColorsList.first(where: { $0.name == task.colorName }) {
            taskIcon.tintColor = matchedColor.color.withAlphaComponent(0.8)
            iconContainerView.layer.borderColor = matchedColor.color.cgColor
        } else {
            taskIcon.tintColor = .gray
        }
        
        let timeText = formateTime(task.time ?? Date())
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.minimumLineHeight = 0
            paragraphStyle.maximumLineHeight = 0
            paragraphStyle.lineSpacing = 0

            taskTimeLabel.attributedText = NSAttributedString(
                string: timeText,
                attributes: [
                    .paragraphStyle: paragraphStyle,
                    .baselineOffset: 0
                ]
            )
    }
    
    func formateTime(_ date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(from: date)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        setUptConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CollectionViewCellTaskOfTheDay: ViewCodeProtocol {
    func addSubViews() {
        contentView.addSubview(stackViewCell)
        contentView.addSubview(deleteButton)
        iconContainerView.addSubview(taskIcon)
    }
    
    func setUptConstraints() {
        NSLayoutConstraint.activate([
            iconContainerView.widthAnchor.constraint(equalToConstant: 60),
            iconContainerView.heightAnchor.constraint(equalToConstant: 60),
                        
            taskIcon.centerXAnchor.constraint(equalTo: iconContainerView.centerXAnchor),
            taskIcon.centerYAnchor.constraint(equalTo: iconContainerView.centerYAnchor),
            taskIcon.widthAnchor.constraint(equalToConstant: 24),
            taskIcon.heightAnchor.constraint(equalToConstant: 24),
            
            stackViewCell.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackViewCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackViewCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackViewCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            deleteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            deleteButton.widthAnchor.constraint(equalToConstant: 12),
            deleteButton.heightAnchor.constraint(equalToConstant: 12),
        ])
    }
    
    
}
