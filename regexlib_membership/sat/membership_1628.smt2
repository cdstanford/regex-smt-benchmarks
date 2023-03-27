;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\[assembly: AssemblyVersion\(\&quot;([0-9]+)\.([0-9]+)\.([0-9]+)\.([0-9]+)
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "[assembly: AssemblyVersion(&quot;38.79.89.288"
(define-fun Witness1 () String (str.++ "[" (str.++ "a" (str.++ "s" (str.++ "s" (str.++ "e" (str.++ "m" (str.++ "b" (str.++ "l" (str.++ "y" (str.++ ":" (str.++ " " (str.++ "A" (str.++ "s" (str.++ "s" (str.++ "e" (str.++ "m" (str.++ "b" (str.++ "l" (str.++ "y" (str.++ "V" (str.++ "e" (str.++ "r" (str.++ "s" (str.++ "i" (str.++ "o" (str.++ "n" (str.++ "(" (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ ";" (str.++ "3" (str.++ "8" (str.++ "." (str.++ "7" (str.++ "9" (str.++ "." (str.++ "8" (str.++ "9" (str.++ "." (str.++ "2" (str.++ "8" (str.++ "8" ""))))))))))))))))))))))))))))))))))))))))))))))
;witness2: "[assembly: AssemblyVersion(&quot;8.8.2.80"
(define-fun Witness2 () String (str.++ "[" (str.++ "a" (str.++ "s" (str.++ "s" (str.++ "e" (str.++ "m" (str.++ "b" (str.++ "l" (str.++ "y" (str.++ ":" (str.++ " " (str.++ "A" (str.++ "s" (str.++ "s" (str.++ "e" (str.++ "m" (str.++ "b" (str.++ "l" (str.++ "y" (str.++ "V" (str.++ "e" (str.++ "r" (str.++ "s" (str.++ "i" (str.++ "o" (str.++ "n" (str.++ "(" (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ ";" (str.++ "8" (str.++ "." (str.++ "8" (str.++ "." (str.++ "2" (str.++ "." (str.++ "8" (str.++ "0" ""))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "[" (str.++ "a" (str.++ "s" (str.++ "s" (str.++ "e" (str.++ "m" (str.++ "b" (str.++ "l" (str.++ "y" (str.++ ":" (str.++ " " (str.++ "A" (str.++ "s" (str.++ "s" (str.++ "e" (str.++ "m" (str.++ "b" (str.++ "l" (str.++ "y" (str.++ "V" (str.++ "e" (str.++ "r" (str.++ "s" (str.++ "i" (str.++ "o" (str.++ "n" (str.++ "(" (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ ";" ""))))))))))))))))))))))))))))))))))(re.++ (re.+ (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ (re.+ (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ (re.+ (re.range "0" "9"))(re.++ (re.range "." ".") (re.+ (re.range "0" "9"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
