;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^ *(1[0-2]|[1-9]):[0-5][0-9] *(a|p|A|P)(m|M) *$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: " 1:48aM"
(define-fun Witness1 () String (seq.++ " " (seq.++ "1" (seq.++ ":" (seq.++ "4" (seq.++ "8" (seq.++ "a" (seq.++ "M" ""))))))))
;witness2: "7:23     pM  "
(define-fun Witness2 () String (seq.++ "7" (seq.++ ":" (seq.++ "2" (seq.++ "3" (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ "p" (seq.++ "M" (seq.++ " " (seq.++ " " ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.range " " " "))(re.++ (re.union (re.++ (re.range "1" "1") (re.range "0" "2")) (re.range "1" "9"))(re.++ (re.range ":" ":")(re.++ (re.range "0" "5")(re.++ (re.range "0" "9")(re.++ (re.* (re.range " " " "))(re.++ (re.union (re.range "A" "A")(re.union (re.range "P" "P")(re.union (re.range "a" "a") (re.range "p" "p"))))(re.++ (re.union (re.range "M" "M") (re.range "m" "m"))(re.++ (re.* (re.range " " " ")) (str.to_re "")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
