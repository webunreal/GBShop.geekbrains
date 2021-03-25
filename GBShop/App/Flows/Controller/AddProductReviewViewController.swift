//
//  AddProductReviewViewController.swift
//  GBShop
//
//  Created by Nikolai Ivanov on 25.03.2021.
//

import UIKit

class AddProductReviewViewController: UIViewController {
    
    private let requestFactory: RequestFactory
    private let user: User
    private let analytics = AppAnalytics()
    private let textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .white
        textView.textColor = .black
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.autocapitalizationType = .words
        return textView
    }()
    
    init(requestFactory: RequestFactory, user: User) {
        self.requestFactory = requestFactory
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = textView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Add Review",
            style: .plain,
            target: self,
            action: #selector(addReview))
    }
    
    @objc private func addReview() {
        let addProductReviewFactory = requestFactory.makeAddProductReviewRequestFactory()
        addProductReviewFactory.addReview(userId: user.id, text: textView.text) { [weak self] response in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch response.result {
                case .success(let reviewAdded):
                    self.analytics.reviewIsAdded()
                    let alert = UIAlertController(title: "Review Added", message: reviewAdded.userMessage, preferredStyle: UIAlertController.Style.alert)
                    self.present(alert, animated: true, completion: nil)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        self.dismiss(animated: true, completion: nil)
                        self.navigationController?.popViewController(animated: true)
                    }
                case .failure(let error):
                    let alert = UIAlertController(title: "Error", message: error.errorDescription, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertAction.Style.default) { _ in
                        self.addReview()
                    })
                    alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}
