;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = :(6553[0-5]|655[0-2][0-9]\d|65[0-4](\d){2}|6[0-4](\d){3}|[1-5](\d){4}|[1-9](\d){0,3})
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: ":655091"
(define-fun Witness1 () String (str.++ ":" (str.++ "6" (str.++ "5" (str.++ "5" (str.++ "0" (str.++ "9" (str.++ "1" ""))))))))
;witness2: ":655089"
(define-fun Witness2 () String (str.++ ":" (str.++ "6" (str.++ "5" (str.++ "5" (str.++ "0" (str.++ "8" (str.++ "9" ""))))))))

(assert (= regexA (re.++ (re.range ":" ":") (re.union (re.++ (str.to_re (str.++ "6" (str.++ "5" (str.++ "5" (str.++ "3" ""))))) (re.range "0" "5"))(re.union (re.++ (str.to_re (str.++ "6" (str.++ "5" (str.++ "5" ""))))(re.++ (re.range "0" "2")(re.++ (re.range "0" "9") (re.range "0" "9"))))(re.union (re.++ (str.to_re (str.++ "6" (str.++ "5" "")))(re.++ (re.range "0" "4") ((_ re.loop 2 2) (re.range "0" "9"))))(re.union (re.++ (re.range "6" "6")(re.++ (re.range "0" "4") ((_ re.loop 3 3) (re.range "0" "9"))))(re.union (re.++ (re.range "1" "5") ((_ re.loop 4 4) (re.range "0" "9"))) (re.++ (re.range "1" "9") ((_ re.loop 0 3) (re.range "0" "9")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
