;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^0{0,1}[1-9]{1}[0-9]{2}[\s]{0,1}[\-]{0,1}[\s]{0,1}[1-9]{1}[0-9]{6}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "9687883457"
(define-fun Witness1 () String (str.++ "9" (str.++ "6" (str.++ "8" (str.++ "7" (str.++ "8" (str.++ "8" (str.++ "3" (str.++ "4" (str.++ "5" (str.++ "7" "")))))))))))
;witness2: "4991890811"
(define-fun Witness2 () String (str.++ "4" (str.++ "9" (str.++ "9" (str.++ "1" (str.++ "8" (str.++ "9" (str.++ "0" (str.++ "8" (str.++ "1" (str.++ "1" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.range "0" "0"))(re.++ (re.range "1" "9")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.range "1" "9")(re.++ ((_ re.loop 6 6) (re.range "0" "9")) (str.to_re ""))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
