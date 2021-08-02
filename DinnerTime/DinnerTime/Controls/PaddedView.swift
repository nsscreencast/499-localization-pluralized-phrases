//
//  PaddedView.swift
//  DinnerTime
//
//  Created by Ben Scheirman on 6/18/21.
//

import UIKit
import SnapKit

class PaddedView: UIView {
    private var wrapped: UIView? {
        willSet {
            wrapped?.removeFromSuperview()
        }
        didSet {
            installWrappedView()
        }
    }
    
    var padding: UIEdgeInsets = UIEdgeInsets(top: 8, left: 4, bottom: 8, right: 4) {
        didSet {
            updatePadding()
        }
    }
    
    init(wrapping: UIView, padding: UIEdgeInsets) {
        self.wrapped = wrapping
        self.padding = padding
        super.init(frame: .zero)
        installWrappedView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func installWrappedView() {
        guard let wrapped = wrapped else { return }
        if wrapped.superview != nil {
            wrapped.removeFromSuperview()
        }
        addSubview(wrapped)
        updatePadding()
    }
    
    func updatePadding() {
        guard let wrapped = wrapped else { return }
        wrapped.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(padding)
        }
    }
}
