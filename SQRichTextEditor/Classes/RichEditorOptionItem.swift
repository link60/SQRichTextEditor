//
//  RichEditorOptionItem.swift
//
//  Created by Caesar Wirth on 4/2/15.
//  Copyright (c) 2015 Caesar Wirth. All rights reserved.
//

import UIKit

/// A RichEditorOption object is an object that can be displayed in a RichEditorToolbar.
/// This protocol is proviced to allow for custom actions not provided in the RichEditorOptions enum.
public protocol RichEditorOption {
	
	/// The image to be displayed in the RichEditorToolbar.
	var image: UIImage? { get }
	
	/// The title of the item.
	/// If `image` is nil, this will be used for display in the RichEditorToolbar.
	var title: String { get }
	
	/// The action to be evoked when the action is tapped
	/// - parameter editor: The RichEditorToolbar that the RichEditorOption was being displayed in when tapped.
	///                     Contains a reference to the `editor` RichEditorView to perform actions on.
	/// - parameter sender: The object that sent the action. Usually a `UIView` from the toolbar item that represents the option.
	func action(_ editor: RichEditorToolbar, sender: AnyObject)
}

/// RichEditorOptionItem is a concrete implementation of RichEditorOption.
/// It can be used as a configuration object for custom objects to be shown on a RichEditorToolbar.
public struct RichEditorOptionItem: RichEditorOption {
	
	/// The image that should be shown when displayed in the RichEditorToolbar.
	public var image: UIImage?
	
	/// If an `itemImage` is not specified, this is used in display
	public var title: String
	
	/// The action to be performed when tapped
	public var handler: ((RichEditorToolbar, AnyObject) -> Void)
	
	public init(image: UIImage? = nil, title: String, action: @escaping ((RichEditorToolbar, AnyObject) -> Void)) {
		self.image = image
		self.title = title
		self.handler = action
	}
	
	public init(title: String, action: @escaping ((RichEditorToolbar, AnyObject) -> Void)) {
		self.init(image: nil, title: title, action: action)
	}
	
	public func action(_ toolbar: RichEditorToolbar, sender: AnyObject) {
		handler(toolbar, sender)
	}
}

/// RichEditorOptions is an enum of standard editor actions
public enum RichEditorDefaultOption: RichEditorOption {
	
	case bold
	case italic
	case strike
	case underline
	
	public static let all: [RichEditorDefaultOption] = [
		.bold, .italic, .underline, .strike
	]
	
	// MARK: RichEditorOption
	
	public var image: UIImage? {
		var name = ""
		switch self {
			case .bold: name = "bold"
			case .italic: name = "italic"
			case .strike: name = "strikethrough"
			case .underline: name = "underline"
		}
		return UIImage(systemName: name)?.withRenderingMode(.alwaysTemplate)
	}
	
	public var title: String {
		switch self {
			case .bold: return NSLocalizedString("Bold", comment: "")
			case .italic: return NSLocalizedString("Italic", comment: "")
			case .strike: return NSLocalizedString("Strike", comment: "")
			case .underline: return NSLocalizedString("Underline", comment: "")
		}
	}
	
	public func action(_ toolbar: RichEditorToolbar, sender: AnyObject) {
		switch self {
			case .bold:   toolbar.editor?.bold()
			case .italic: toolbar.editor?.italic()
			case .strike: toolbar.editor?.strikethrough()
			case .underline: toolbar.editor?.underline()
		}
	}
}
