;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([0-9]|1[0-9]|2[0-4])(\.[0-9][0-9]?)?)$|([2][5](\.[0][0]?)?)$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00B6\u0098\u00BA\x18M25.00"
(define-fun Witness1 () String (str.++ "\u{b6}" (str.++ "\u{98}" (str.++ "\u{ba}" (str.++ "\u{18}" (str.++ "M" (str.++ "2" (str.++ "5" (str.++ "." (str.++ "0" (str.++ "0" "")))))))))))
;witness2: "21"
(define-fun Witness2 () String (str.++ "2" (str.++ "1" "")))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.++ (re.union (re.range "0" "9")(re.union (re.++ (re.range "1" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "4")))) (re.opt (re.++ (re.range "." ".")(re.++ (re.range "0" "9") (re.opt (re.range "0" "9")))))) (str.to_re ""))) (re.++ (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.opt (re.++ (str.to_re (str.++ "." (str.++ "0" ""))) (re.opt (re.range "0" "0"))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
