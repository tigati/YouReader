import Foundation

enum RemoteData<T, E: Error> {
    case notAsked
    case loading
    case success(T)
    case updating(T)
    case failure(E)
}

extension RemoteData {
    var isLoading: Bool {
        guard case .loading = self else { return false }
        return true
    }

    var isEmpty: Bool {
        guard case .notAsked = self else { return false }
        return true
    }
    var data: T? {
        get {
            guard case let .success(someInfo) = self else { return nil }
            return someInfo
        }
        set {
            guard case .success = self,
                let newInfo = newValue
                else { return }
            self = .success(newInfo)
        }
    }
}

extension RemoteData {
    public var value: T? {
        switch self {
        case .success(let value):
            return value
        default:
            return nil
        }
    }

    public var error: E? {
        switch self {
        case .failure(let error):
            return error
        default:
            return nil
        }
    }
}
