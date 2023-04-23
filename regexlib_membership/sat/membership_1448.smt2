;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^([0-9]|[0-1][0-9]|[2][0-3]):([0-5][0-9])(\s{0,1})([AM|PM|am|pm]{2,2})$)|(^([0-9]|[1][0-9]|[2][0-3])(\s{0,1})([AM|PM|am|pm]{2,2})$)
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "09:28AM"
(define-fun Witness1 () String (str.++ "0" (str.++ "9" (str.++ ":" (str.++ "2" (str.++ "8" (str.++ "A" (str.++ "M" ""))))))))
;witness2: "23:12MA"
(define-fun Witness2 () String (str.++ "2" (str.++ "3" (str.++ ":" (str.++ "1" (str.++ "2" (str.++ "M" (str.++ "A" ""))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.union (re.range "0" "9")(re.union (re.++ (re.range "0" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3"))))(re.++ (re.range ":" ":")(re.++ (re.++ (re.range "0" "5") (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 2 2) (re.union (re.range "A" "A")(re.union (re.range "M" "M")(re.union (re.range "P" "P")(re.union (re.range "a" "a")(re.union (re.range "m" "m")(re.union (re.range "p" "p") (re.range "|" "|")))))))) (str.to_re ""))))))) (re.++ (str.to_re "")(re.++ (re.union (re.range "0" "9")(re.union (re.++ (re.range "1" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3"))))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 2 2) (re.union (re.range "A" "A")(re.union (re.range "M" "M")(re.union (re.range "P" "P")(re.union (re.range "a" "a")(re.union (re.range "m" "m")(re.union (re.range "p" "p") (re.range "|" "|")))))))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
