//
//  RichEditorWebView.swift
//  SQRichTextEditor
//
//  Created by Loïc SENCE on 01/11/2023.
//

import WebKit

public class RichEditorWebView: WKWebView {
	
	public var accessoryView: UIView?
	
	public override var inputAccessoryView: UIView? {
		return accessoryView
	}
	
}
