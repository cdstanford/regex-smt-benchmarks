;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[a-zA-Z]{1,3}\[([0-9]{1,3})\]
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "S[9]\xA\"
(define-fun Witness1 () String (str.++ "S" (str.++ "[" (str.++ "9" (str.++ "]" (str.++ "\u{0a}" (str.++ "\u{5c}" "")))))))
;witness2: "O[8]\x5\u00E6\u00C3\u00F9\x1\u0087"
(define-fun Witness2 () String (str.++ "O" (str.++ "[" (str.++ "8" (str.++ "]" (str.++ "\u{05}" (str.++ "\u{e6}" (str.++ "\u{c3}" (str.++ "\u{f9}" (str.++ "\u{01}" (str.++ "\u{87}" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 1 3) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.range "[" "[")(re.++ ((_ re.loop 1 3) (re.range "0" "9")) (re.range "]" "]")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
