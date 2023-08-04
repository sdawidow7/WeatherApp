import Combine

// https://tanaschita.com/20220822-bridge-async-await-to-combine-future/
extension Future where Failure == Error {
    convenience init(asyncFunc: @escaping () async throws -> Output) {
        self.init { promise in
            Task {
                do {
                    let result = try await asyncFunc()
                    promise(.success(result))
                } catch {
                    promise(.failure(error))
                }
            }
        }
    }
}
