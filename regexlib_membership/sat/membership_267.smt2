;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0][1-9]|[1][0-2]):[0-5][0-9] {1}(AM|PM|am|pm)$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "05:54 PM"
(define-fun Witness1 () String (str.++ "0" (str.++ "5" (str.++ ":" (str.++ "5" (str.++ "4" (str.++ " " (str.++ "P" (str.++ "M" "")))))))))
;witness2: "12:49 AM"
(define-fun Witness2 () String (str.++ "1" (str.++ "2" (str.++ ":" (str.++ "4" (str.++ "9" (str.++ " " (str.++ "A" (str.++ "M" "")))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9")) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (re.range ":" ":")(re.++ (re.range "0" "5")(re.++ (re.range "0" "9")(re.++ (re.range " " " ")(re.++ (re.union (str.to_re (str.++ "A" (str.++ "M" "")))(re.union (str.to_re (str.++ "P" (str.++ "M" "")))(re.union (str.to_re (str.++ "a" (str.++ "m" ""))) (str.to_re (str.++ "p" (str.++ "m" "")))))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
