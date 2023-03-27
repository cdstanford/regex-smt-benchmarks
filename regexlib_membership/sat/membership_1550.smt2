;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\d{3}\s?\d{3}\s?\d{3}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "899829897"
(define-fun Witness1 () String (str.++ "8" (str.++ "9" (str.++ "9" (str.++ "8" (str.++ "2" (str.++ "9" (str.++ "8" (str.++ "9" (str.++ "7" ""))))))))))
;witness2: "184\u00A0069 836"
(define-fun Witness2 () String (str.++ "1" (str.++ "8" (str.++ "4" (str.++ "\u{a0}" (str.++ "0" (str.++ "6" (str.++ "9" (str.++ " " (str.++ "8" (str.++ "3" (str.++ "6" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
