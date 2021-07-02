//
//  DetailViewController.swift
//  64Collection
//
//  Created by admin on 2021/4/25.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var pageView: UIView!
    @IBOutlet weak var brandNameLabel: UILabel!
    @IBOutlet weak var brandLogoImageView: UIImageView!
    @IBOutlet weak var typeNameLabel: UILabel!
    @IBOutlet weak var typeMakeLabel: UILabel!
    @IBOutlet weak var typeCategoryLabel: UILabel!
    @IBOutlet weak var typeDiecastBrandLabel: UILabel!
    @IBOutlet weak var typeViewCountLabel: UILabel!
    var typeId: String?
//    let dataSource = [
//    "https://i.pinimg.com/originals/7f/7f/36/7f7f36313d5f03175087a828dce5982d.jpg", "https://static1.srcdn.com/wordpress/wp-content/uploads/2021/03/Among-Us-Random-Name-Generator.jpg?q=50&fit=crop&w=960&h=500&dpr=1.5"
//    ]
    var currentViewControllerIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // print(typeDto!.imgUrls)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        BackendService.shared.retrieveOneType(typeId: typeId!, changeListener: reloadData)
    }

    func reloadData() {
        brandNameLabel.text = BackendService.shared.tempBrandType?.brandName
        ImageUtils.shared.load(imageView: brandLogoImageView, from: BackendService.shared.tempBrandType!.iconUrl)
        typeNameLabel.text = BackendService.shared.tempBrandType!.typeName ?? "*TypeName*"
        typeMakeLabel.text = String(BackendService.shared.tempBrandType!.make)
        typeCategoryLabel.text = "Category: \(BackendService.shared.tempBrandType!.category)"
        typeDiecastBrandLabel.text = "Diecast Brand: \(BackendService.shared.tempBrandType!.diecastBrand)"
        typeViewCountLabel.text = "Viewed \(BackendService.shared.tempBrandType!.viewTimes) times"
        if BackendService.shared.tempBrandType!.imgUrls.isEmpty {
            return
        }
        configurePageViewController()
    }

    func configurePageViewController() {
        guard let pageViewController =
        storyboard?.instantiateViewController(identifier: "PageViewController") as? UIPageViewController
                else {
            print("didn't get controller")
            return
        }
        pageViewController.delegate = self
        pageViewController.dataSource = self
        addChild(pageViewController)
        pageViewController.didMove(toParent: self)
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false

        pageViewController.view.backgroundColor = UIColor.black
        pageView.addSubview(pageViewController.view)

        let views: [String: Any] = ["pageView": pageViewController.view!]

        pageView.addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[pageView]-0-|",
                        options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                        metrics: nil,
                        views: views))
        pageView.addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[pageView]-0-|",
                        options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                        metrics: nil,
                        views: views))

        guard let startingViewController = detailViewControllerAt(index: self.currentViewControllerIndex) else {
            print("didnt get view controller")
            return
        }
        pageViewController.setViewControllers([startingViewController],
                direction: .forward,
                animated: true,
                completion: nil)
    }

    func detailViewControllerAt(index: Int) -> ImageDetailViewController? {
        if index >= BackendService.shared.tempBrandType!.imgUrls.count || BackendService.shared.tempBrandType!.imgUrls.count == 0 {
            return nil
        }
        guard let imageDetailViewController = storyboard?.instantiateViewController(identifier: String(describing: ImageDetailViewController.self)) as? ImageDetailViewController else {
            return nil
        }
        imageDetailViewController.index = index
        imageDetailViewController.imgUrl = BackendService.shared.tempBrandType!.imgUrls[index]
        return imageDetailViewController
    }
}

extension DetailViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        currentViewControllerIndex
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        BackendService.shared.tempBrandType!.imgUrls.count
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let imageDetailViewController = viewController as! ImageDetailViewController

        guard var currentIndex = imageDetailViewController.index else {
            return nil
        }
        if currentIndex == 0 {
            return nil
        }
        currentIndex -= 1
        currentViewControllerIndex = currentIndex
        return detailViewControllerAt(index: currentIndex)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let imageDetailViewController = viewController as! ImageDetailViewController
        guard var currentIndex = imageDetailViewController.index else {
            return nil
        }
        if currentIndex == BackendService.shared.tempBrandType!.imgUrls.count {
            return nil
        }
        currentIndex += 1
        currentViewControllerIndex = currentIndex
        return detailViewControllerAt(index: currentIndex)
    }
}
