import CLAPACK
import XCTest

class Test: XCTestCase {
  func testIsUsable() {
    let S: [[Double]] = [
      [1, 2, 3, 4, 5, 6],
      [2, 3, 4, 5, 6, 7],
      [3, 4, 5, 6, 7, 8],
      [4, 5, 6, 7, 8, 9],
      [5, 6, 7, 8, 9, 10],
      [6, 7, 8, 9, 10, 11],
    ]

    var C = [[Double]](repeating: [Double](repeating: 0, count: 6), count: 6)
    C[0][2] = -2.0
    C[1][1] = 1.0
    C[2][0] = -2.0

    // The order of the matrices A, B, VL, and VR.  N >= 0
    let N = UnsafeMutablePointer<Int>.allocate(capacity: 1)
    N[0] = 6

    // On entry, the matrix A in the pair (A,B).
    let A = UnsafeMutablePointer<Double>.allocate(capacity: 6 * 6)
    for i in 0..<6 {
      for j in 0..<6 {
        A[i * 6 + j] = S[i][j]
      }
    }

    // The leading dimension of A
    let LDA = UnsafeMutablePointer<Int>.allocate(capacity: 1)
    LDA[0] = 6

    // On entry, the matrix B in the pair (A,B).
    let B = UnsafeMutablePointer<Double>.allocate(capacity: 6 * 6)
    for i in 0..<6 {
      for j in 0..<6 {
        B[i * 6 + j] = C[i][j]
      }
    }

    // The leading dimension of B
    let LDB = UnsafeMutablePointer<Int>.allocate(capacity: 1)
    LDB[0] = 6

    let ALPHAR = UnsafeMutablePointer<Double>.allocate(capacity: 6)
    let ALPHAI = UnsafeMutablePointer<Double>.allocate(capacity: 6)
    let BETA = UnsafeMutablePointer<Double>.allocate(capacity: 6)

    // The leading dimension of the matrix VL
    let LDVL = UnsafeMutablePointer<Int>.allocate(capacity: 1)
    LDVL[0] = 6

    // The leading dimension of the matrix VR
    let LDVR = UnsafeMutablePointer<Int>.allocate(capacity: 1)
    LDVR[0] = 6

    let VL = UnsafeMutablePointer<Double>.allocate(capacity: 36)
    let VR = UnsafeMutablePointer<Double>.allocate(capacity: 36)

    let ILO = UnsafeMutablePointer<Int>.allocate(capacity: 1)
    let IHI = UnsafeMutablePointer<Int>.allocate(capacity: 1)

    let LSCALE = UnsafeMutablePointer<Double>.allocate(capacity: 6)
    let RSCALE = UnsafeMutablePointer<Double>.allocate(capacity: 6)

    let ABNRM = UnsafeMutablePointer<Double>.allocate(capacity: 6)
    let BBNRM = UnsafeMutablePointer<Double>.allocate(capacity: 6)

    let RCONDE = UnsafeMutablePointer<Double>.allocate(capacity: 6)
    let RCONDV = UnsafeMutablePointer<Double>.allocate(capacity: 6)

    // If BALANC = 'S' or 'B', or JOBVL = 'V', or JOBVR = 'V', LWORK >= max(1,6*N).
    let LWORK = UnsafeMutablePointer<Int>.allocate(capacity: 1)
    LWORK[0] = 36
    let WORK = UnsafeMutablePointer<Double>.allocate(capacity: 36)

    let IWORK = UnsafeMutablePointer<Int>.allocate(capacity: 12)
    let BWORK = UnsafeMutablePointer<Int>.allocate(capacity: 6)

    let INFO = UnsafeMutablePointer<Int>.allocate(capacity: 1)

    var BALANC: CChar = 66  // 'B'
    var JOBVL: CChar = 86  // ascii for 'V'
    var SENSE: CChar = 78  // ascii for 'N'
    var JOBVR: CChar = 86

    let before = ALPHAR[0]

    dggevx_(
      &BALANC, &JOBVL, &JOBVR, &SENSE, N, A, LDA, B, LDB, ALPHAR, ALPHAI, BETA, VL, LDVL, VR, LDVR,
      ILO, IHI, LSCALE, RSCALE, ABNRM, BBNRM, RCONDE, RCONDV, WORK, LWORK, IWORK, BWORK, INFO)

    XCTAssertNotEqual(before, ALPHAR[0])
  }
}
