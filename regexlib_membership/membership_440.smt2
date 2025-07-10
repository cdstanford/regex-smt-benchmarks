;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\+{1}|00)\s{0,1}([0-9]{3}|[0-9]{2})\s{0,1}\-{0,1}\s{0,1}([0-9]{2}|[1-9]{1})\s{0,1}\-{0,1}\s{0,1}([0-9]{8}|[0-9]{7})
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "+8129\u00A0- 96968999"
(define-fun Witness1 () String (str.++ "+" (str.++ "8" (str.++ "1" (str.++ "2" (str.++ "9" (str.++ "\u{a0}" (str.++ "-" (str.++ " " (str.++ "9" (str.++ "6" (str.++ "9" (str.++ "6" (str.++ "8" (str.++ "9" (str.++ "9" (str.++ "9" "")))))))))))))))))
;witness2: "+593\xC96\u00A08968573"
(define-fun Witness2 () String (str.++ "+" (str.++ "5" (str.++ "9" (str.++ "3" (str.++ "\u{0c}" (str.++ "9" (str.++ "6" (str.++ "\u{a0}" (str.++ "8" (str.++ "9" (str.++ "6" (str.++ "8" (str.++ "5" (str.++ "7" (str.++ "3" ""))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "+" "+") (str.to_re (str.++ "0" (str.++ "0" ""))))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.union ((_ re.loop 3 3) (re.range "0" "9")) ((_ re.loop 2 2) (re.range "0" "9")))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.union ((_ re.loop 2 2) (re.range "0" "9")) (re.range "1" "9"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (re.union ((_ re.loop 8 8) (re.range "0" "9")) ((_ re.loop 7 7) (re.range "0" "9"))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
