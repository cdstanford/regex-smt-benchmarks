;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([A-Z]{2}\s?(\d{2})?(-)?([A-Z]{1}|\d{1})?([A-Z]{1}|\d{1}))$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "JZ84-I4"
(define-fun Witness1 () String (str.++ "J" (str.++ "Z" (str.++ "8" (str.++ "4" (str.++ "-" (str.++ "I" (str.++ "4" ""))))))))
;witness2: "CY68-7T"
(define-fun Witness2 () String (str.++ "C" (str.++ "Y" (str.++ "6" (str.++ "8" (str.++ "-" (str.++ "7" (str.++ "T" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ ((_ re.loop 2 2) (re.range "A" "Z"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt ((_ re.loop 2 2) (re.range "0" "9")))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.union (re.range "0" "9") (re.range "A" "Z"))) (re.union (re.range "0" "9") (re.range "A" "Z"))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
