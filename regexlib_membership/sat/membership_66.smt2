;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \(\d{3}\)\040\d{3}-\d{4}
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "(781) 689-89421\u00F6"
(define-fun Witness1 () String (str.++ "(" (str.++ "7" (str.++ "8" (str.++ "1" (str.++ ")" (str.++ " " (str.++ "6" (str.++ "8" (str.++ "9" (str.++ "-" (str.++ "8" (str.++ "9" (str.++ "4" (str.++ "2" (str.++ "1" (str.++ "\u{f6}" "")))))))))))))))))
;witness2: "\x8(258) 898-1014"
(define-fun Witness2 () String (str.++ "\u{08}" (str.++ "(" (str.++ "2" (str.++ "5" (str.++ "8" (str.++ ")" (str.++ " " (str.++ "8" (str.++ "9" (str.++ "8" (str.++ "-" (str.++ "1" (str.++ "0" (str.++ "1" (str.++ "4" ""))))))))))))))))

(assert (= regexA (re.++ (re.range "(" "(")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (str.to_re (str.++ ")" (str.++ " " "")))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 4 4) (re.range "0" "9")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
