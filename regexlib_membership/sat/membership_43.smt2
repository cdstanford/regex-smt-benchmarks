;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^ *([0-1]?[0-9]|[2][0-3]):[0-5][0-9] *(a|p|A|P)(m|M) *$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "   8:47 PM  "
(define-fun Witness1 () String (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ "8" (seq.++ ":" (seq.++ "4" (seq.++ "7" (seq.++ " " (seq.++ "P" (seq.++ "M" (seq.++ " " (seq.++ " " "")))))))))))))
;witness2: "9:47Pm"
(define-fun Witness2 () String (seq.++ "9" (seq.++ ":" (seq.++ "4" (seq.++ "7" (seq.++ "P" (seq.++ "m" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.range " " " "))(re.++ (re.union (re.++ (re.opt (re.range "0" "1")) (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3")))(re.++ (re.range ":" ":")(re.++ (re.range "0" "5")(re.++ (re.range "0" "9")(re.++ (re.* (re.range " " " "))(re.++ (re.union (re.range "A" "A")(re.union (re.range "P" "P")(re.union (re.range "a" "a") (re.range "p" "p"))))(re.++ (re.union (re.range "M" "M") (re.range "m" "m"))(re.++ (re.* (re.range " " " ")) (str.to_re "")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
