//
//  ReactionContainerView.swift
//  InstaReactionInteraction-iOS
//
//  Created by Artem Zabihailo on 14.06.2024.
//

import UIKit

final class ReactionContainerView: UIView {
    
    // MARK: - Interface
    
    private let container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Constants.verticalStackViewSpacing
        stackView.addArrangedSubview(topTitleLabel)
        stackView.addArrangedSubview(actionsStackView)
        return stackView
    }()
    
    private let topTitleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.topLabelText
        label.textColor = .darkText
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    lazy var actionsStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.spacing = Constants.stackViewSpacing
        view.isUserInteractionEnabled = false
        return view
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        container.layer.cornerRadius = container.frame.height / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    func setupActions(reactionActions: [ReactionAction]) {
        for reaction in reactionActions {
            let subview = makeReactionLabel(reaction: reaction)
            actionsStackView.addArrangedSubview(subview)
        }
    }
    
    // MARK: - Private methods
    
    private func makeReactionLabel(reaction: ReactionAction) -> UILabel {
        let label = UILabel()
        label.text = reaction.title
        label.font = .systemFont(ofSize: Constants.reactionLabelFontSize)
        return label
    }
    
    private func setupUI() {
        addSubview(container)
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        container.addSubview(verticalStackView)
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: container.topAnchor, constant: Constants.verticalStackViewVInset),
            verticalStackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: Constants.verticalStackViewHInset),
            verticalStackView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -Constants.verticalStackViewHInset),
            verticalStackView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -Constants.verticalStackViewVInset)
        ])
    }
    
    private struct Constants {
        static let topLabelText: String = "Tap and hold to react"
        static let stackViewSpacing: CGFloat = 20
        static let reactionLabelFontSize: CGFloat = 30
        static let verticalStackViewSpacing: CGFloat = 7
        static let verticalStackViewVInset: CGFloat = 10
        static let verticalStackViewHInset: CGFloat = 15
    }
}
