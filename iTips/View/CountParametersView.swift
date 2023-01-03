import UIKit

// MARK: - CountParametersViewDelegate protocol
protocol CountParametersViewDelegate: AnyObject {
    func calculateTapped(withBill bill: String?, tipsPercent tips: Float, andNumberOfPersons persons: Float)
    func tipsPercentChanged(to value: String)
    func personsAmountChanged(to value: String)
}

// MARK: - CountParametersView
final class CountParametersView: UIView {

    // MARK: - Properties and Initializers
    weak var delegate: CountParametersViewDelegate?

    let billTotalTextField: UITextField = {
        let textField = UITextField()
        textField.toAutolayout()
        textField.font = UIFont(name: "Gill Sans", size: UIScreen.screenSize(heightDividedBy: 20))
        textField.textColor = .itBrown
        textField.attributedPlaceholder = NSAttributedString(string: "e.g. 123.45",
                                                             attributes: [
                                                                NSAttributedString.Key.foregroundColor: UIColor.itGray
                                                             ])
        textField.textAlignment = .center
        textField.keyboardType = .decimalPad
        return textField
    }()

    private lazy var topStackView: UIStackView = {
        let stackView = makeStackView(axis: .vertical, alignment: .fill, distribution: .fill)
        stackView.toAutolayout()
        stackView.addArrangedSubview(makeLabel(withText: "Bill total:", alignment: .left))
        stackView.addArrangedSubview(billTotalTextField)
        return stackView
    }()

    lazy var tipsAmountInfoLabel: UILabel = {
        makeLabel(withText: "0 %", alignment: .right)
    }()

    private lazy var tipsAmountInfoStackView: UIStackView = {
        let stackView = makeStackView(axis: .horizontal, alignment: .fill, distribution: .fill)
        stackView.toAutolayout()
        stackView.addArrangedSubview(makeLabel(withText: "Tips amount (in percents):", alignment: .natural))
        tipsAmountInfoLabel.setContentHuggingPriority(UILayoutPriority(251), for: .horizontal)
        stackView.addArrangedSubview(tipsAmountInfoLabel)
        return stackView
    }()

    private lazy var tipsAmountSlider: UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = .itBrown
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = 0
        slider.addTarget(self, action: #selector(tipsPercentChanged), for: .valueChanged)
        return slider
    }()

    private lazy var tipsAmountPropertiesStackView: UIStackView = {
        let stackView = makeStackView(axis: .horizontal, alignment: .fill, distribution: .fill)
        stackView.toAutolayout()
        stackView.addArrangedSubview(makeLabel(withText: "0", alignment: .natural))
        stackView.addArrangedSubview(tipsAmountSlider)
        stackView.addArrangedSubview(makeLabel(withText: "100", alignment: .natural))
        return stackView
    }()

    lazy var personsAmountInfoLabel: UILabel = {
        makeLabel(withText: "1", alignment: .center)
    }()

    private lazy var personsStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.minimumValue = 1
        stepper.maximumValue = 100
        stepper.value = 1
        stepper.addTarget(self, action: #selector(personsAmountChanged), for: .valueChanged)
        return stepper
    }()

    private lazy var personsPropertiesStackView: UIStackView = {
        let stackView = makeStackView(axis: .horizontal, alignment: .fill, distribution: .fill, withSpacing: 30)
        stackView.toAutolayout()
        stackView.addArrangedSubview(makeLabel(withText: "Persons:", alignment: .natural))
        personsAmountInfoLabel.setContentHuggingPriority(UILayoutPriority(249), for: .horizontal)
        stackView.addArrangedSubview(personsAmountInfoLabel)
        stackView.addArrangedSubview(personsStepper)
        return stackView
    }()

    private let bottomView: UIView = {
        let view = UIView()
        view.toAutolayout()
        view.backgroundColor = .itGreenDark
        return view
    }()

    private lazy var calculateButton: UIButton = {
        let button = UIButton()
        button.toAutolayout()
        button.titleLabel?.font = UIFont(name: "Gill Sans", size: UIScreen.screenSize(heightDividedBy: 25))
        button.setTitle("Calculate", for: .normal)
        button.setTitleColor(.itBrown, for: .normal)
        button.backgroundColor = .itPurple
        button.layer.cornerRadius = UIScreen.screenSize(heightDividedBy: 80)
        button.addTarget(self, action: #selector(calculateTapped), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .itGreenLight
        toAutolayout()
        addSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers
extension CountParametersView {

    @objc private func calculateTapped() {
        delegate?.calculateTapped(withBill: billTotalTextField.text,
                                  tipsPercent: tipsAmountSlider.value,
                                  andNumberOfPersons: Float(personsStepper.value))
    }

    @objc private func tipsPercentChanged() {
        delegate?.tipsPercentChanged(to: "\(String(Int(tipsAmountSlider.value))) %")
    }

    @objc private func personsAmountChanged() {
        delegate?.personsAmountChanged(to: String(Int(personsStepper.value)))
    }

    private func addSubviews() {
        addSubview(topStackView)
        bottomView.addSubview(tipsAmountInfoStackView)
        bottomView.addSubview(tipsAmountPropertiesStackView)
        bottomView.addSubview(personsPropertiesStackView)
        addSubview(bottomView)
        addSubview(calculateButton)
    }

    private func setupConstraints() {
        let constraints = [
            topStackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 120),
            topStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            topStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 3),
            topStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -3),
            tipsAmountInfoStackView.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 24),
            tipsAmountInfoStackView.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 3
            ),
            tipsAmountInfoStackView.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -3
            ),
            tipsAmountPropertiesStackView.topAnchor.constraint(
                equalTo: tipsAmountInfoStackView.bottomAnchor, constant: 30
            ),
            tipsAmountPropertiesStackView.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 3
            ),
            tipsAmountPropertiesStackView.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -3
            ),
            personsPropertiesStackView.topAnchor.constraint(
                equalTo: tipsAmountPropertiesStackView.bottomAnchor, constant: 30
            ),
            personsPropertiesStackView.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 3
            ),
            personsPropertiesStackView.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -3
            ),
            bottomView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 30),
            bottomView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: bottomAnchor),
            calculateButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 200),
            calculateButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
            calculateButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            calculateButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
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

    private func makeLabel(withText text: String,
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
