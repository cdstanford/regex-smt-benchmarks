;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (script)|(&lt;)|(&gt;)|(%3c)|(%3e)|(SELECT) |(UPDATE) |(INSERT) |(DELETE)|(GRANT) |(REVOKE)|(UNION)|(&amp;lt;)|(&amp;gt;)
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "&lt;`"
(define-fun Witness1 () String (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "`" ""))))))
;witness2: "%3c"
(define-fun Witness2 () String (str.++ "%" (str.++ "3" (str.++ "c" ""))))

(assert (= regexA (re.union (str.to_re (str.++ "s" (str.++ "c" (str.++ "r" (str.++ "i" (str.++ "p" (str.++ "t" "")))))))(re.union (str.to_re (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" "")))))(re.union (str.to_re (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" "")))))(re.union (str.to_re (str.++ "%" (str.++ "3" (str.++ "c" ""))))(re.union (str.to_re (str.++ "%" (str.++ "3" (str.++ "e" ""))))(re.union (re.++ (str.to_re (str.++ "S" (str.++ "E" (str.++ "L" (str.++ "E" (str.++ "C" (str.++ "T" ""))))))) (re.range " " " "))(re.union (re.++ (str.to_re (str.++ "U" (str.++ "P" (str.++ "D" (str.++ "A" (str.++ "T" (str.++ "E" ""))))))) (re.range " " " "))(re.union (re.++ (str.to_re (str.++ "I" (str.++ "N" (str.++ "S" (str.++ "E" (str.++ "R" (str.++ "T" ""))))))) (re.range " " " "))(re.union (str.to_re (str.++ "D" (str.++ "E" (str.++ "L" (str.++ "E" (str.++ "T" (str.++ "E" "")))))))(re.union (re.++ (str.to_re (str.++ "G" (str.++ "R" (str.++ "A" (str.++ "N" (str.++ "T" "")))))) (re.range " " " "))(re.union (str.to_re (str.++ "R" (str.++ "E" (str.++ "V" (str.++ "O" (str.++ "K" (str.++ "E" "")))))))(re.union (str.to_re (str.++ "U" (str.++ "N" (str.++ "I" (str.++ "O" (str.++ "N" ""))))))(re.union (str.to_re (str.++ "&" (str.++ "a" (str.++ "m" (str.++ "p" (str.++ ";" (str.++ "l" (str.++ "t" (str.++ ";" ""))))))))) (str.to_re (str.++ "&" (str.++ "a" (str.++ "m" (str.++ "p" (str.++ ";" (str.++ "g" (str.++ "t" (str.++ ";" ""))))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
