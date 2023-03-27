;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (refs|references|re|closes|closed|close|see|fixes|fixed|fix|addresses) #(\d+)(( and |, | & | )#(\d+))*
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "+9closes #0\u00C0"
(define-fun Witness1 () String (str.++ "+" (str.++ "9" (str.++ "c" (str.++ "l" (str.++ "o" (str.++ "s" (str.++ "e" (str.++ "s" (str.++ " " (str.++ "#" (str.++ "0" (str.++ "\u{c0}" "")))))))))))))
;witness2: "closes #88847\u00CB\u00D7"
(define-fun Witness2 () String (str.++ "c" (str.++ "l" (str.++ "o" (str.++ "s" (str.++ "e" (str.++ "s" (str.++ " " (str.++ "#" (str.++ "8" (str.++ "8" (str.++ "8" (str.++ "4" (str.++ "7" (str.++ "\u{cb}" (str.++ "\u{d7}" ""))))))))))))))))

(assert (= regexA (re.++ (re.union (str.to_re (str.++ "r" (str.++ "e" (str.++ "f" (str.++ "s" "")))))(re.union (str.to_re (str.++ "r" (str.++ "e" (str.++ "f" (str.++ "e" (str.++ "r" (str.++ "e" (str.++ "n" (str.++ "c" (str.++ "e" (str.++ "s" "")))))))))))(re.union (str.to_re (str.++ "r" (str.++ "e" "")))(re.union (str.to_re (str.++ "c" (str.++ "l" (str.++ "o" (str.++ "s" (str.++ "e" (str.++ "s" "")))))))(re.union (str.to_re (str.++ "c" (str.++ "l" (str.++ "o" (str.++ "s" (str.++ "e" (str.++ "d" "")))))))(re.union (str.to_re (str.++ "c" (str.++ "l" (str.++ "o" (str.++ "s" (str.++ "e" ""))))))(re.union (str.to_re (str.++ "s" (str.++ "e" (str.++ "e" ""))))(re.union (str.to_re (str.++ "f" (str.++ "i" (str.++ "x" (str.++ "e" (str.++ "s" ""))))))(re.union (str.to_re (str.++ "f" (str.++ "i" (str.++ "x" (str.++ "e" (str.++ "d" ""))))))(re.union (str.to_re (str.++ "f" (str.++ "i" (str.++ "x" "")))) (str.to_re (str.++ "a" (str.++ "d" (str.++ "d" (str.++ "r" (str.++ "e" (str.++ "s" (str.++ "s" (str.++ "e" (str.++ "s" ""))))))))))))))))))))(re.++ (str.to_re (str.++ " " (str.++ "#" "")))(re.++ (re.+ (re.range "0" "9")) (re.* (re.++ (re.union (str.to_re (str.++ " " (str.++ "a" (str.++ "n" (str.++ "d" (str.++ " " ""))))))(re.union (str.to_re (str.++ "," (str.++ " " "")))(re.union (str.to_re (str.++ " " (str.++ "&" (str.++ " " "")))) (re.range " " " "))))(re.++ (re.range "#" "#") (re.+ (re.range "0" "9"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
