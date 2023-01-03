import UIKit

// MARK: - CountParametersController
final class CountParametersController: UIViewController {

    // MARK: - Properties and Initializers
    private var presenter: CountParametersPresenter?
    lazy var countParametersView: CountParametersView = {
        let view = CountParametersView()
        return view
    }()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(countParametersView)
        setupConstraints()
        presenter = CountParametersPresenter(viewController: self)
    }
}

// MARK: - Helpers
extension CountParametersController {

    private func setupConstraints() {
        let constraints = [
            countParametersView.topAnchor.constraint(equalTo: view.topAnchor),
            countParametersView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            countParametersView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            countParametersView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
