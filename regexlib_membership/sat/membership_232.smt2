;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \$(\d)*\d
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00E7\u0082$58\u009B\u00BDY\u00C9A\u0094\u00D8\u0093"
(define-fun Witness1 () String (str.++ "\u{e7}" (str.++ "\u{82}" (str.++ "$" (str.++ "5" (str.++ "8" (str.++ "\u{9b}" (str.++ "\u{bd}" (str.++ "Y" (str.++ "\u{c9}" (str.++ "A" (str.++ "\u{94}" (str.++ "\u{d8}" (str.++ "\u{93}" ""))))))))))))))
;witness2: "x\u00F5$758777922687"
(define-fun Witness2 () String (str.++ "x" (str.++ "\u{f5}" (str.++ "$" (str.++ "7" (str.++ "5" (str.++ "8" (str.++ "7" (str.++ "7" (str.++ "7" (str.++ "9" (str.++ "2" (str.++ "2" (str.++ "6" (str.++ "8" (str.++ "7" ""))))))))))))))))

(assert (= regexA (re.++ (re.range "$" "$")(re.++ (re.* (re.range "0" "9")) (re.range "0" "9")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
