;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0][1-9]|[1][0-2]):[0-5][0-9] {1}(AM|PM|am|pm)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "05:54 PM"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "5" (seq.++ ":" (seq.++ "5" (seq.++ "4" (seq.++ " " (seq.++ "P" (seq.++ "M" "")))))))))
;witness2: "12:49 AM"
(define-fun Witness2 () String (seq.++ "1" (seq.++ "2" (seq.++ ":" (seq.++ "4" (seq.++ "9" (seq.++ " " (seq.++ "A" (seq.++ "M" "")))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9")) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (re.range ":" ":")(re.++ (re.range "0" "5")(re.++ (re.range "0" "9")(re.++ (re.range " " " ")(re.++ (re.union (str.to_re (seq.++ "A" (seq.++ "M" "")))(re.union (str.to_re (seq.++ "P" (seq.++ "M" "")))(re.union (str.to_re (seq.++ "a" (seq.++ "m" ""))) (str.to_re (seq.++ "p" (seq.++ "m" "")))))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
