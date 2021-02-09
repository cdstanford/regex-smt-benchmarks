;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (script)|(&lt;)|(&gt;)|(%3c)|(%3e)|(SELECT) |(UPDATE) |(INSERT) |(DELETE)|(GRANT) |(REVOKE)|(UNION)|(&amp;lt;)|(&amp;gt;)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "&lt;`"
(define-fun Witness1 () String (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "`" ""))))))
;witness2: "%3c"
(define-fun Witness2 () String (seq.++ "%" (seq.++ "3" (seq.++ "c" ""))))

(assert (= regexA (re.union (str.to_re (seq.++ "s" (seq.++ "c" (seq.++ "r" (seq.++ "i" (seq.++ "p" (seq.++ "t" "")))))))(re.union (str.to_re (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" "")))))(re.union (str.to_re (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" "")))))(re.union (str.to_re (seq.++ "%" (seq.++ "3" (seq.++ "c" ""))))(re.union (str.to_re (seq.++ "%" (seq.++ "3" (seq.++ "e" ""))))(re.union (re.++ (str.to_re (seq.++ "S" (seq.++ "E" (seq.++ "L" (seq.++ "E" (seq.++ "C" (seq.++ "T" ""))))))) (re.range " " " "))(re.union (re.++ (str.to_re (seq.++ "U" (seq.++ "P" (seq.++ "D" (seq.++ "A" (seq.++ "T" (seq.++ "E" ""))))))) (re.range " " " "))(re.union (re.++ (str.to_re (seq.++ "I" (seq.++ "N" (seq.++ "S" (seq.++ "E" (seq.++ "R" (seq.++ "T" ""))))))) (re.range " " " "))(re.union (str.to_re (seq.++ "D" (seq.++ "E" (seq.++ "L" (seq.++ "E" (seq.++ "T" (seq.++ "E" "")))))))(re.union (re.++ (str.to_re (seq.++ "G" (seq.++ "R" (seq.++ "A" (seq.++ "N" (seq.++ "T" "")))))) (re.range " " " "))(re.union (str.to_re (seq.++ "R" (seq.++ "E" (seq.++ "V" (seq.++ "O" (seq.++ "K" (seq.++ "E" "")))))))(re.union (str.to_re (seq.++ "U" (seq.++ "N" (seq.++ "I" (seq.++ "O" (seq.++ "N" ""))))))(re.union (str.to_re (seq.++ "&" (seq.++ "a" (seq.++ "m" (seq.++ "p" (seq.++ ";" (seq.++ "l" (seq.++ "t" (seq.++ ";" ""))))))))) (str.to_re (seq.++ "&" (seq.++ "a" (seq.++ "m" (seq.++ "p" (seq.++ ";" (seq.++ "g" (seq.++ "t" (seq.++ ";" ""))))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
