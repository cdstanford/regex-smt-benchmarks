;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\d{1,2})(\s?(H|h)?)(:([0-5]\d))?$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "68\xD:49"
(define-fun Witness1 () String (str.++ "6" (str.++ "8" (str.++ "\u{0d}" (str.++ ":" (str.++ "4" (str.++ "9" "")))))))
;witness2: "9:54"
(define-fun Witness2 () String (str.++ "9" (str.++ ":" (str.++ "5" (str.++ "4" "")))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (re.opt (re.union (re.range "H" "H") (re.range "h" "h"))))(re.++ (re.opt (re.++ (re.range ":" ":") (re.++ (re.range "0" "5") (re.range "0" "9")))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
