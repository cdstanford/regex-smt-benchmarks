;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0-9]{4})-([0-1][0-9])-([0-3][0-9])\s([0-1][0-9]|[2][0-3]):([0-5][0-9]):([0-5][0-9])$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "7827-00-13 22:09:09"
(define-fun Witness1 () String (seq.++ "7" (seq.++ "8" (seq.++ "2" (seq.++ "7" (seq.++ "-" (seq.++ "0" (seq.++ "0" (seq.++ "-" (seq.++ "1" (seq.++ "3" (seq.++ " " (seq.++ "2" (seq.++ "2" (seq.++ ":" (seq.++ "0" (seq.++ "9" (seq.++ ":" (seq.++ "0" (seq.++ "9" ""))))))))))))))))))))
;witness2: "1597-17-19\u008507:15:48"
(define-fun Witness2 () String (seq.++ "1" (seq.++ "5" (seq.++ "9" (seq.++ "7" (seq.++ "-" (seq.++ "1" (seq.++ "7" (seq.++ "-" (seq.++ "1" (seq.++ "9" (seq.++ "\x85" (seq.++ "0" (seq.++ "7" (seq.++ ":" (seq.++ "1" (seq.++ "5" (seq.++ ":" (seq.++ "4" (seq.++ "8" ""))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ (re.++ (re.range "0" "1") (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ (re.++ (re.range "0" "3") (re.range "0" "9"))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ (re.union (re.++ (re.range "0" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3")))(re.++ (re.range ":" ":")(re.++ (re.++ (re.range "0" "5") (re.range "0" "9"))(re.++ (re.range ":" ":")(re.++ (re.++ (re.range "0" "5") (re.range "0" "9")) (str.to_re "")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
