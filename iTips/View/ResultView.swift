import UIKit

// MARK: - ResultViewDelegate protocol
protocol ResultViewDelegate: AnyObject {
    func recalculateTapped()
}

// MARK: - ResultView
final class ResultView: UIView {

    // MARK: - Properties and Initializers
    weak var delegate: ResultViewDelegate?

    lazy var totalPerPersonLabel: UILabel = {
        makeLabel(sized: UIScreen.screenSize(heightDividedBy: 15), alignment: .center)
    }()

    private lazy var topStackView: UIStackView = {
        let stackView = makeStackView(axis: .vertical, alignment: .fill, distribution: .fill)
        stackView.toAutolayout()
        stackView.addArrangedSubview(makeLabel(withText: "Total per person:", alignment: .natural))
        stackView.addArrangedSubview(totalPerPersonLabel)
        return stackView
    }()

    lazy var totalInfoLabel: UILabel = {
        let label = makeLabel(alignment: .natural)
        label.toAutolayout()
        return label
    }()

    private let bottomView: UIView = {
        let view = UIView()
        view.toAutolayout()
        view.backgroundColor = .itGreenLight
        return view
    }()

    private lazy var recalculateButton: UIButton = {
        let button = UIButton()
        button.toAutolayout()
        button.titleLabel?.font = UIFont(name: "Gill Sans", size: UIScreen.screenSize(heightDividedBy: 25))
        button.setTitle("Recalculate", for: .normal)
        button.setTitleColor(.itBrown, for: .normal)
        button.backgroundColor = .itPurple
        button.layer.cornerRadius = UIScreen.screenSize(heightDividedBy: 80)
        button.addTarget(self, action: #selector(recalculateTapped), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .itGreenDark
        toAutolayout()
        addSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers
extension ResultView {

    @objc private func recalculateTapped() {
        delegate?.recalculateTapped()
    }

    private func addSubviews() {
        addSubview(topStackView)
        bottomView.addSubview(totalInfoLabel)
        addSubview(bottomView)
        addSubview(recalculateButton)
    }

    private func setupConstraints() {
        let constraints = [
            topStackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 120),
            topStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            topStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 3),
            topStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -3),
            bottomView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 30),
            bottomView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: bottomAnchor),
            totalInfoLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 24),
            totalInfoLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            recalculateButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 200),
            recalculateButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
            recalculateButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            recalculateButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func makeStackView(axis: NSLayoutConstraint.Axis, alignment: UIStackView.Alignment,
                               distribution: UIStackView.Distribution, withSpacing spacing: CGFloat = 5
    ) -> UIStackView {
        let stackView = UIStackView()
        stackView.toAutolayout()
        stackView.axis = axis
        stackView.alignment = alignment
        stackView.distribution = distribution
        stackView.backgroundColor = .clear
        stackView.spacing = spacing
        return stackView
    }

    private func makeLabel(withText text: String = "",
                           sized size: CGFloat = UIScreen.screenSize(heightDividedBy: 35),
                           alignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.font =  UIFont(name: "Gill Sans", size: size)
        label.textAlignment = alignment
        label.numberOfLines = 1
        label.textColor = .itBrown
        label.text = text
        return label
    }
}
