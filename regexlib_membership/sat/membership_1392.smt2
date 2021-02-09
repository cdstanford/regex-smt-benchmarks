;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([1-9]{1})|([0-1][1-2])|(0[1-9])|([1][0-2])):([0-5][0-9])(([aA])|([pP]))[mM]$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "1:38pm"
(define-fun Witness1 () String (seq.++ "1" (seq.++ ":" (seq.++ "3" (seq.++ "8" (seq.++ "p" (seq.++ "m" "")))))))
;witness2: "3:54PM"
(define-fun Witness2 () String (seq.++ "3" (seq.++ ":" (seq.++ "5" (seq.++ "4" (seq.++ "P" (seq.++ "M" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "1" "9")(re.union (re.++ (re.range "0" "1") (re.range "1" "2"))(re.union (re.++ (re.range "0" "0") (re.range "1" "9")) (re.++ (re.range "1" "1") (re.range "0" "2")))))(re.++ (re.range ":" ":")(re.++ (re.++ (re.range "0" "5") (re.range "0" "9"))(re.++ (re.union (re.union (re.range "A" "A") (re.range "a" "a")) (re.union (re.range "P" "P") (re.range "p" "p")))(re.++ (re.union (re.range "M" "M") (re.range "m" "m")) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
