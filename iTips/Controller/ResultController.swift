import UIKit

// MARK: - ResultController
final class ResultController: UIViewController {

    // MARK: - Properties and Initializers
    private var presenter: ResultPresenter?
    lazy var resultView: ResultView = {
        let view = ResultView()
        return view
    }()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }

    convenience init(forBill billModel: BillModel) {
        self.init()
        presenter = ResultPresenter(viewController: self)
        presenter?.fillUI(using: billModel)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(resultView)
        setupConstraints()
    }
}

// MARK: - Helpers
extension ResultController {

    private func setupConstraints() {
        let constraints = [
            resultView.topAnchor.constraint(equalTo: view.topAnchor),
            resultView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            resultView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            resultView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
