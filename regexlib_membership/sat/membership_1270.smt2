;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\d{5}((\-|\s)?\d{4})?$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "59192 3470"
(define-fun Witness1 () String (str.++ "5" (str.++ "9" (str.++ "1" (str.++ "9" (str.++ "2" (str.++ " " (str.++ "3" (str.++ "4" (str.++ "7" (str.++ "0" "")))))))))))
;witness2: "198649058"
(define-fun Witness2 () String (str.++ "1" (str.++ "9" (str.++ "8" (str.++ "6" (str.++ "4" (str.++ "9" (str.++ "0" (str.++ "5" (str.++ "8" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 5 5) (re.range "0" "9"))(re.++ (re.opt (re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))) ((_ re.loop 4 4) (re.range "0" "9")))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
