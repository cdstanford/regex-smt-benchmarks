;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\s*(\d{0,2})(\.?(\d*))?\s*\%?\s*$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "9 \x9"
(define-fun Witness1 () String (str.++ "9" (str.++ " " (str.++ "\u{09}" ""))))
;witness2: "3.6%"
(define-fun Witness2 () String (str.++ "3" (str.++ "." (str.++ "6" (str.++ "%" "")))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 0 2) (re.range "0" "9"))(re.++ (re.opt (re.++ (re.opt (re.range "." ".")) (re.* (re.range "0" "9"))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "%" "%"))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
