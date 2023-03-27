;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^100$|^\s*(\d{0,2})((\.|\,)(\d*))?\s*\%?\s*$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00A0\u00A09\u0085% \u00A0"
(define-fun Witness1 () String (str.++ "\u{a0}" (str.++ "\u{a0}" (str.++ "9" (str.++ "\u{85}" (str.++ "%" (str.++ " " (str.++ "\u{a0}" ""))))))))
;witness2: "100"
(define-fun Witness2 () String (str.++ "1" (str.++ "0" (str.++ "0" ""))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "1" (str.++ "0" (str.++ "0" "")))) (str.to_re ""))) (re.++ (str.to_re "")(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 0 2) (re.range "0" "9"))(re.++ (re.opt (re.++ (re.union (re.range "," ",") (re.range "." ".")) (re.* (re.range "0" "9"))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "%" "%"))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
