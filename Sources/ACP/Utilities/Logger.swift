//
//  Logger+ACP.swift
//  ACP
//
//  Logging utility for ACP
//

import Foundation
import Logging

public struct Logger: Sendable {
    private let label: String

    public init(subsystem: String, category: String) {
        self.label = "\(subsystem).\(category)"
    }

    public func trace(_ message: @autoclosure () -> String) { log(level: .trace, message: message()) }
    public func debug(_ message: @autoclosure () -> String) { log(level: .debug, message: message()) }
    public func info(_ message: @autoclosure () -> String) { log(level: .info, message: message()) }
    public func notice(_ message: @autoclosure () -> String) { log(level: .notice, message: message()) }
    public func warning(_ message: @autoclosure () -> String) { log(level: .warning, message: message()) }
    public func error(_ message: @autoclosure () -> String) { log(level: .error, message: message()) }
    public func critical(_ message: @autoclosure () -> String) { log(level: .critical, message: message()) }
    public func fault(_ message: @autoclosure () -> String) { log(level: .critical, message: message()) }

    private func log(level: Logging.Logger.Level, message: String) {
        let handler = StreamLogHandler.standardError(label: label)
        handler.log(level: level, message: .init(stringLiteral: message), metadata: nil, source: label, file: #fileID, function: #function, line: #line)
    }
}

extension Logger {
    /// Default subsystem for ACP logging
    private static var acpSubsystem = "com.acp"

    /// Configure the logging subsystem (call once at initialization)
    public static func configureACPLogging(subsystem: String) {
        acpSubsystem = subsystem
    }

    /// Create a logger for a specific category
    public static func forCategory(_ category: String) -> Logger {
        Logger(subsystem: acpSubsystem, category: category)
    }

    /// Convenience logger for ACP
    public static let acp = Logger.forCategory("ACP")
}
