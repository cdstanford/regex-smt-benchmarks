;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (([1-9]|[0][1-9])|1[012])[- /.](([1-9]|[0][1-9])|[12][0-9]|3[01])[- /.](19|20)\d\d
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "11 30 2062\u00BF"
(define-fun Witness1 () String (seq.++ "1" (seq.++ "1" (seq.++ " " (seq.++ "3" (seq.++ "0" (seq.++ " " (seq.++ "2" (seq.++ "0" (seq.++ "6" (seq.++ "2" (seq.++ "\xbf" ""))))))))))))
;witness2: "11 8 2088\u00C8"
(define-fun Witness2 () String (seq.++ "1" (seq.++ "1" (seq.++ " " (seq.++ "8" (seq.++ " " (seq.++ "2" (seq.++ "0" (seq.++ "8" (seq.++ "8" (seq.++ "\xc8" "")))))))))))

(assert (= regexA (re.++ (re.union (re.union (re.range "1" "9") (re.++ (re.range "0" "0") (re.range "1" "9"))) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (re.union (re.range " " " ") (re.range "-" "/"))(re.++ (re.union (re.union (re.range "1" "9") (re.++ (re.range "0" "0") (re.range "1" "9")))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1"))))(re.++ (re.union (re.range " " " ") (re.range "-" "/"))(re.++ (re.union (str.to_re (seq.++ "1" (seq.++ "9" ""))) (str.to_re (seq.++ "2" (seq.++ "0" ""))))(re.++ (re.range "0" "9") (re.range "0" "9")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
