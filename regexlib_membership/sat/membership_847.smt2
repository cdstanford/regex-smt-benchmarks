;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (refs|references|re|closes|closed|close|see|fixes|fixed|fix|addresses) #(\d+)(( and |, | & | )#(\d+))*
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "+9closes #0\u00C0"
(define-fun Witness1 () String (seq.++ "+" (seq.++ "9" (seq.++ "c" (seq.++ "l" (seq.++ "o" (seq.++ "s" (seq.++ "e" (seq.++ "s" (seq.++ " " (seq.++ "#" (seq.++ "0" (seq.++ "\xc0" "")))))))))))))
;witness2: "closes #88847\u00CB\u00D7"
(define-fun Witness2 () String (seq.++ "c" (seq.++ "l" (seq.++ "o" (seq.++ "s" (seq.++ "e" (seq.++ "s" (seq.++ " " (seq.++ "#" (seq.++ "8" (seq.++ "8" (seq.++ "8" (seq.++ "4" (seq.++ "7" (seq.++ "\xcb" (seq.++ "\xd7" ""))))))))))))))))

(assert (= regexA (re.++ (re.union (str.to_re (seq.++ "r" (seq.++ "e" (seq.++ "f" (seq.++ "s" "")))))(re.union (str.to_re (seq.++ "r" (seq.++ "e" (seq.++ "f" (seq.++ "e" (seq.++ "r" (seq.++ "e" (seq.++ "n" (seq.++ "c" (seq.++ "e" (seq.++ "s" "")))))))))))(re.union (str.to_re (seq.++ "r" (seq.++ "e" "")))(re.union (str.to_re (seq.++ "c" (seq.++ "l" (seq.++ "o" (seq.++ "s" (seq.++ "e" (seq.++ "s" "")))))))(re.union (str.to_re (seq.++ "c" (seq.++ "l" (seq.++ "o" (seq.++ "s" (seq.++ "e" (seq.++ "d" "")))))))(re.union (str.to_re (seq.++ "c" (seq.++ "l" (seq.++ "o" (seq.++ "s" (seq.++ "e" ""))))))(re.union (str.to_re (seq.++ "s" (seq.++ "e" (seq.++ "e" ""))))(re.union (str.to_re (seq.++ "f" (seq.++ "i" (seq.++ "x" (seq.++ "e" (seq.++ "s" ""))))))(re.union (str.to_re (seq.++ "f" (seq.++ "i" (seq.++ "x" (seq.++ "e" (seq.++ "d" ""))))))(re.union (str.to_re (seq.++ "f" (seq.++ "i" (seq.++ "x" "")))) (str.to_re (seq.++ "a" (seq.++ "d" (seq.++ "d" (seq.++ "r" (seq.++ "e" (seq.++ "s" (seq.++ "s" (seq.++ "e" (seq.++ "s" ""))))))))))))))))))))(re.++ (str.to_re (seq.++ " " (seq.++ "#" "")))(re.++ (re.+ (re.range "0" "9")) (re.* (re.++ (re.union (str.to_re (seq.++ " " (seq.++ "a" (seq.++ "n" (seq.++ "d" (seq.++ " " ""))))))(re.union (str.to_re (seq.++ "," (seq.++ " " "")))(re.union (str.to_re (seq.++ " " (seq.++ "&" (seq.++ " " "")))) (re.range " " " "))))(re.++ (re.range "#" "#") (re.+ (re.range "0" "9"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
