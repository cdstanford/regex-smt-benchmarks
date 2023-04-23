;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0-9]{6}[\s\-]{1}[0-9]{12}|[0-9]{18})$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "228798 512989699985"
(define-fun Witness1 () String (str.++ "2" (str.++ "2" (str.++ "8" (str.++ "7" (str.++ "9" (str.++ "8" (str.++ " " (str.++ "5" (str.++ "1" (str.++ "2" (str.++ "9" (str.++ "8" (str.++ "9" (str.++ "6" (str.++ "9" (str.++ "9" (str.++ "9" (str.++ "8" (str.++ "5" ""))))))))))))))))))))
;witness2: "882899\u00A0899809598620"
(define-fun Witness2 () String (str.++ "8" (str.++ "8" (str.++ "2" (str.++ "8" (str.++ "9" (str.++ "9" (str.++ "\u{a0}" (str.++ "8" (str.++ "9" (str.++ "9" (str.++ "8" (str.++ "0" (str.++ "9" (str.++ "5" (str.++ "9" (str.++ "8" (str.++ "6" (str.++ "2" (str.++ "0" ""))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ ((_ re.loop 6 6) (re.range "0" "9"))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) ((_ re.loop 12 12) (re.range "0" "9")))) ((_ re.loop 18 18) (re.range "0" "9"))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
