;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\[assembly: AssemblyVersion\(\&quot;([0-9]+)\.([0-9]+)\.([0-9]+)\.([0-9]+)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "[assembly: AssemblyVersion(&quot;38.79.89.288"
(define-fun Witness1 () String (seq.++ "[" (seq.++ "a" (seq.++ "s" (seq.++ "s" (seq.++ "e" (seq.++ "m" (seq.++ "b" (seq.++ "l" (seq.++ "y" (seq.++ ":" (seq.++ " " (seq.++ "A" (seq.++ "s" (seq.++ "s" (seq.++ "e" (seq.++ "m" (seq.++ "b" (seq.++ "l" (seq.++ "y" (seq.++ "V" (seq.++ "e" (seq.++ "r" (seq.++ "s" (seq.++ "i" (seq.++ "o" (seq.++ "n" (seq.++ "(" (seq.++ "&" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" (seq.++ "3" (seq.++ "8" (seq.++ "." (seq.++ "7" (seq.++ "9" (seq.++ "." (seq.++ "8" (seq.++ "9" (seq.++ "." (seq.++ "2" (seq.++ "8" (seq.++ "8" ""))))))))))))))))))))))))))))))))))))))))))))))
;witness2: "[assembly: AssemblyVersion(&quot;8.8.2.80"
(define-fun Witness2 () String (seq.++ "[" (seq.++ "a" (seq.++ "s" (seq.++ "s" (seq.++ "e" (seq.++ "m" (seq.++ "b" (seq.++ "l" (seq.++ "y" (seq.++ ":" (seq.++ " " (seq.++ "A" (seq.++ "s" (seq.++ "s" (seq.++ "e" (seq.++ "m" (seq.++ "b" (seq.++ "l" (seq.++ "y" (seq.++ "V" (seq.++ "e" (seq.++ "r" (seq.++ "s" (seq.++ "i" (seq.++ "o" (seq.++ "n" (seq.++ "(" (seq.++ "&" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" (seq.++ "8" (seq.++ "." (seq.++ "8" (seq.++ "." (seq.++ "2" (seq.++ "." (seq.++ "8" (seq.++ "0" ""))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "[" (seq.++ "a" (seq.++ "s" (seq.++ "s" (seq.++ "e" (seq.++ "m" (seq.++ "b" (seq.++ "l" (seq.++ "y" (seq.++ ":" (seq.++ " " (seq.++ "A" (seq.++ "s" (seq.++ "s" (seq.++ "e" (seq.++ "m" (seq.++ "b" (seq.++ "l" (seq.++ "y" (seq.++ "V" (seq.++ "e" (seq.++ "r" (seq.++ "s" (seq.++ "i" (seq.++ "o" (seq.++ "n" (seq.++ "(" (seq.++ "&" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" ""))))))))))))))))))))))))))))))))))(re.++ (re.+ (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ (re.+ (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ (re.+ (re.range "0" "9"))(re.++ (re.range "." ".") (re.+ (re.range "0" "9"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
