//
//  BaseViewController.swift
//  neopin-connect-iOS-DApp
//
//  Created by Neopin on 2022/08/02.
//

import UIKit
//import RxSwift

class BaseViewController: UIViewController {
    // MARK: - Constants
    enum Color {
        static let neopinMain = UIColor(red: 26/255, green: 183/255, blue: 235/255, alpha: 1)
        static let empty = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1)
    }
    
    // MARK: - Properties
    lazy private(set) var className: String = {
        return type(of: self).description().components(separatedBy: ".").last ?? ""
    }()
    
    var automaticallyAdjustsLeftBarButtonItem = true
    private var scrollViewOriginalContentInsetAdjustmentBehaviorRawValue: Int?
    
    
    // MARK: - Initializing
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    deinit {
        print("\(#function) DEINIT: \(self.className)")
    }
    
    // MARK: - View Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.automaticallyAdjustsLeftBarButtonItem {
            self.adjustLeftBarButtonItem()
        }
        
        // fix iOS 11 scroll view bug
        if #available(iOS 11, *) {
            if let scrollView = self.view.subviews.first as? UIScrollView {
                self.scrollViewOriginalContentInsetAdjustmentBehaviorRawValue =
                scrollView.contentInsetAdjustmentBehavior.rawValue
                scrollView.contentInsetAdjustmentBehavior = .never
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // fix iOS 11 scroll view bug
        if #available(iOS 11, *) {
            if let scrollView = self.view.subviews.first as? UIScrollView,
               let rawValue = self.scrollViewOriginalContentInsetAdjustmentBehaviorRawValue,
               let behavior = UIScrollView.ContentInsetAdjustmentBehavior(rawValue: rawValue) {
                scrollView.contentInsetAdjustmentBehavior = behavior
            }
        }
    }
    
    // MARK: - UI
    private(set) var didSetupConstraints = false
    
    override func viewDidLoad() {
        self.view.setNeedsUpdateConstraints()
        self.view.backgroundColor = .white
    }
    
    override func updateViewConstraints() {
        if !self.didSetupConstraints {
            self.setupConstraints()
            self.didSetupConstraints = true
        }
        super.updateViewConstraints()
    }
    
    func setupConstraints() {
        // Override point
    }
}

extension BaseViewController {
    // MARK: Adjusting Navigation Item
    func adjustLeftBarButtonItem() {
        if self.navigationController?.viewControllers.count ?? 0 > 1 { // pushed
            self.navigationItem.leftBarButtonItem = nil
        } else if self.presentingViewController != nil { // presented
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(
                barButtonSystemItem: .cancel,
                target: self,
                action: #selector(cancelButtonDidTap)
            )
        }
    }
    
    @objc func cancelButtonDidTap() {
        self.dismiss(animated: true, completion: nil)
    }
}

