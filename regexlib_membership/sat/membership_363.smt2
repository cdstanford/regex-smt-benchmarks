;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\+91(-)?|91(-)?|0(-)?)?(9)[0-9]{9}
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "0-9988997085"
(define-fun Witness1 () String (str.++ "0" (str.++ "-" (str.++ "9" (str.++ "9" (str.++ "8" (str.++ "8" (str.++ "9" (str.++ "9" (str.++ "7" (str.++ "0" (str.++ "8" (str.++ "5" "")))))))))))))
;witness2: "\x10-+91-9952287199\u00D4\u00CA\u00C1\u00D7"
(define-fun Witness2 () String (str.++ "\u{10}" (str.++ "-" (str.++ "+" (str.++ "9" (str.++ "1" (str.++ "-" (str.++ "9" (str.++ "9" (str.++ "5" (str.++ "2" (str.++ "2" (str.++ "8" (str.++ "7" (str.++ "1" (str.++ "9" (str.++ "9" (str.++ "\u{d4}" (str.++ "\u{ca}" (str.++ "\u{c1}" (str.++ "\u{d7}" "")))))))))))))))))))))

(assert (= regexA (re.++ (re.opt (re.union (re.++ (str.to_re (str.++ "+" (str.++ "9" (str.++ "1" "")))) (re.opt (re.range "-" "-")))(re.union (re.++ (str.to_re (str.++ "9" (str.++ "1" ""))) (re.opt (re.range "-" "-"))) (re.++ (re.range "0" "0") (re.opt (re.range "-" "-"))))))(re.++ (re.range "9" "9") ((_ re.loop 9 9) (re.range "0" "9"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
