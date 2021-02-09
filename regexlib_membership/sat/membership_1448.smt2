;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^([0-9]|[0-1][0-9]|[2][0-3]):([0-5][0-9])(\s{0,1})([AM|PM|am|pm]{2,2})$)|(^([0-9]|[1][0-9]|[2][0-3])(\s{0,1})([AM|PM|am|pm]{2,2})$)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "09:28AM"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "9" (seq.++ ":" (seq.++ "2" (seq.++ "8" (seq.++ "A" (seq.++ "M" ""))))))))
;witness2: "23:12MA"
(define-fun Witness2 () String (seq.++ "2" (seq.++ "3" (seq.++ ":" (seq.++ "1" (seq.++ "2" (seq.++ "M" (seq.++ "A" ""))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.union (re.range "0" "9")(re.union (re.++ (re.range "0" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3"))))(re.++ (re.range ":" ":")(re.++ (re.++ (re.range "0" "5") (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 2 2) (re.union (re.range "A" "A")(re.union (re.range "M" "M")(re.union (re.range "P" "P")(re.union (re.range "a" "a")(re.union (re.range "m" "m")(re.union (re.range "p" "p") (re.range "|" "|")))))))) (str.to_re ""))))))) (re.++ (str.to_re "")(re.++ (re.union (re.range "0" "9")(re.union (re.++ (re.range "1" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3"))))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 2 2) (re.union (re.range "A" "A")(re.union (re.range "M" "M")(re.union (re.range "P" "P")(re.union (re.range "a" "a")(re.union (re.range "m" "m")(re.union (re.range "p" "p") (re.range "|" "|")))))))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
