;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = &lt;table&gt;(&lt;tr&gt;((&lt;td&gt;([A-Za-z0-9])*&lt;/td&gt;)+)&lt;/tr&gt;)*&lt;/table&gt;
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "&lt;table&gt;&lt;/table&gt;C"
(define-fun Witness1 () String (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "t" (seq.++ "a" (seq.++ "b" (seq.++ "l" (seq.++ "e" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "/" (seq.++ "t" (seq.++ "a" (seq.++ "b" (seq.++ "l" (seq.++ "e" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" (seq.++ "C" "")))))))))))))))))))))))))))))
;witness2: "&lt;table&gt;&lt;tr&gt;&lt;td&gt;&lt;/td&gt;&lt;td&gt;7&lt;/td&gt;&lt;/tr&gt;&lt;tr&gt;&lt;td&gt;8&lt;/td&gt;&lt;/tr&gt;&lt;tr&gt;&lt;td&gt;&lt;/td&gt;&lt;/tr&gt;&lt;/table&gt;+"
(define-fun Witness2 () String (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "t" (seq.++ "a" (seq.++ "b" (seq.++ "l" (seq.++ "e" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "t" (seq.++ "r" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "t" (seq.++ "d" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "/" (seq.++ "t" (seq.++ "d" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "t" (seq.++ "d" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" (seq.++ "7" (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "/" (seq.++ "t" (seq.++ "d" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "/" (seq.++ "t" (seq.++ "r" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "t" (seq.++ "r" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "t" (seq.++ "d" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" (seq.++ "8" (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "/" (seq.++ "t" (seq.++ "d" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "/" (seq.++ "t" (seq.++ "r" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "t" (seq.++ "r" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "t" (seq.++ "d" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "/" (seq.++ "t" (seq.++ "d" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "/" (seq.++ "t" (seq.++ "r" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "/" (seq.++ "t" (seq.++ "a" (seq.++ "b" (seq.++ "l" (seq.++ "e" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" (seq.++ "+" ""))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "t" (seq.++ "a" (seq.++ "b" (seq.++ "l" (seq.++ "e" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" ""))))))))))))))(re.++ (re.* (re.++ (str.to_re (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "t" (seq.++ "r" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" "")))))))))))(re.++ (re.+ (re.++ (str.to_re (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "t" (seq.++ "d" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" "")))))))))))(re.++ (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))) (str.to_re (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "/" (seq.++ "t" (seq.++ "d" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" ""))))))))))))))) (str.to_re (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "/" (seq.++ "t" (seq.++ "r" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" ""))))))))))))))) (str.to_re (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "/" (seq.++ "t" (seq.++ "a" (seq.++ "b" (seq.++ "l" (seq.++ "e" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" "")))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
