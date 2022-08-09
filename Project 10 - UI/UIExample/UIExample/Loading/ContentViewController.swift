//
//  ContentViewController.swift
//  UIExample
//
//  Created by jc.kim on 8/9/22.
//

import UIKit

class ContentViewController: UIViewController {
    private let loader = ContentLoader()

    func loadContent() {
        let loadingVC = LoadingViewController()
        add(loadingVC)

        loader.load { [weak self] content in
            loadingVC.remove()
            self?.render(content)
        }
    }
    
    @IBAction func loadButtonDidTap(_ sender: Any) {
        loadContent()
    }
}

// --- Accessories for demo purposes ---

private class ContentLoader {
    struct Content {}

    func load(then handler: @escaping (Content) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            handler(Content())
        }
    }
}

private extension ContentViewController {
    func render(_ content: ContentLoader.Content) {
        // ...
        print("3초가 지나면 꺼짐.. 받아온 요청이 render가 완료됐을 때 호출. ")
    }
}

