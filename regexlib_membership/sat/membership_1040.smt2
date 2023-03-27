;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = &lt;table&gt;(&lt;tr&gt;((&lt;td&gt;([A-Za-z0-9])*&lt;/td&gt;)+)&lt;/tr&gt;)*&lt;/table&gt;
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "&lt;table&gt;&lt;/table&gt;C"
(define-fun Witness1 () String (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "t" (str.++ "a" (str.++ "b" (str.++ "l" (str.++ "e" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "/" (str.++ "t" (str.++ "a" (str.++ "b" (str.++ "l" (str.++ "e" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" (str.++ "C" "")))))))))))))))))))))))))))))
;witness2: "&lt;table&gt;&lt;tr&gt;&lt;td&gt;&lt;/td&gt;&lt;td&gt;7&lt;/td&gt;&lt;/tr&gt;&lt;tr&gt;&lt;td&gt;8&lt;/td&gt;&lt;/tr&gt;&lt;tr&gt;&lt;td&gt;&lt;/td&gt;&lt;/tr&gt;&lt;/table&gt;+"
(define-fun Witness2 () String (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "t" (str.++ "a" (str.++ "b" (str.++ "l" (str.++ "e" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "t" (str.++ "r" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "t" (str.++ "d" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "/" (str.++ "t" (str.++ "d" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "t" (str.++ "d" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" (str.++ "7" (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "/" (str.++ "t" (str.++ "d" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "/" (str.++ "t" (str.++ "r" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "t" (str.++ "r" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "t" (str.++ "d" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" (str.++ "8" (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "/" (str.++ "t" (str.++ "d" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "/" (str.++ "t" (str.++ "r" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "t" (str.++ "r" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "t" (str.++ "d" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "/" (str.++ "t" (str.++ "d" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "/" (str.++ "t" (str.++ "r" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "/" (str.++ "t" (str.++ "a" (str.++ "b" (str.++ "l" (str.++ "e" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" (str.++ "+" ""))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "t" (str.++ "a" (str.++ "b" (str.++ "l" (str.++ "e" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" ""))))))))))))))(re.++ (re.* (re.++ (str.to_re (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "t" (str.++ "r" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" "")))))))))))(re.++ (re.+ (re.++ (str.to_re (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "t" (str.++ "d" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" "")))))))))))(re.++ (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))) (str.to_re (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "/" (str.++ "t" (str.++ "d" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" ""))))))))))))))) (str.to_re (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "/" (str.++ "t" (str.++ "r" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" ""))))))))))))))) (str.to_re (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "/" (str.++ "t" (str.++ "a" (str.++ "b" (str.++ "l" (str.++ "e" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" "")))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
