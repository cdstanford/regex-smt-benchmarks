;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [0-9A-Fa-f]{2}(\.?)[0-9A-Fa-f]{2}(\.?)[0-9A-Fa-f]{2}(\.?)[0-9A-Fa-f]{2}
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00FE(e\u0088\u00F2f3.F0F9.F9"
(define-fun Witness1 () String (str.++ "\u{fe}" (str.++ "(" (str.++ "e" (str.++ "\u{88}" (str.++ "\u{f2}" (str.++ "f" (str.++ "3" (str.++ "." (str.++ "F" (str.++ "0" (str.++ "F" (str.++ "9" (str.++ "." (str.++ "F" (str.++ "9" ""))))))))))))))))
;witness2: "19.FFd8a9"
(define-fun Witness2 () String (str.++ "1" (str.++ "9" (str.++ "." (str.++ "F" (str.++ "F" (str.++ "d" (str.++ "8" (str.++ "a" (str.++ "9" ""))))))))))

(assert (= regexA (re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.opt (re.range "." "."))(re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.opt (re.range "." "."))(re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.opt (re.range "." ".")) ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
