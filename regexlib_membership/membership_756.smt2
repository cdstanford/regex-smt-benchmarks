;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(( )*\£{0,1}( )*)\d*(.\d{1,2})?$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00A3 "
(define-fun Witness1 () String (str.++ "\u{a3}" (str.++ " " "")))
;witness2: "86H8"
(define-fun Witness2 () String (str.++ "8" (str.++ "6" (str.++ "H" (str.++ "8" "")))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.* (re.range " " " "))(re.++ (re.opt (re.range "\u{a3}" "\u{a3}")) (re.* (re.range " " " "))))(re.++ (re.* (re.range "0" "9"))(re.++ (re.opt (re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")) ((_ re.loop 1 2) (re.range "0" "9")))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
