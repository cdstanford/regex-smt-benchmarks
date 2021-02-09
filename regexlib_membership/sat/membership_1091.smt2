;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = &lt;img .+ src[ ]*=[ ]*\&quot;(.+)\&quot;
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "[\xB&lt;img p\x7 src =&quot;\u00A9&quot;\x1E\u00F8"
(define-fun Witness1 () String (seq.++ "[" (seq.++ "\x0b" (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "i" (seq.++ "m" (seq.++ "g" (seq.++ " " (seq.++ "p" (seq.++ "\x07" (seq.++ " " (seq.++ "s" (seq.++ "r" (seq.++ "c" (seq.++ " " (seq.++ "=" (seq.++ "&" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" (seq.++ "\xa9" (seq.++ "&" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" (seq.++ "\x1e" (seq.++ "\xf8" ""))))))))))))))))))))))))))))))))))
;witness2: "&lt;img \x18\x2+\u0087 src =   &quot;\u009B&quot;"
(define-fun Witness2 () String (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "i" (seq.++ "m" (seq.++ "g" (seq.++ " " (seq.++ "\x18" (seq.++ "\x02" (seq.++ "+" (seq.++ "\x87" (seq.++ " " (seq.++ "s" (seq.++ "r" (seq.++ "c" (seq.++ " " (seq.++ "=" (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ "&" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" (seq.++ "\x9b" (seq.++ "&" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" "")))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "i" (seq.++ "m" (seq.++ "g" (seq.++ " " "")))))))))(re.++ (re.+ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (str.to_re (seq.++ " " (seq.++ "s" (seq.++ "r" (seq.++ "c" "")))))(re.++ (re.* (re.range " " " "))(re.++ (re.range "=" "=")(re.++ (re.* (re.range " " " "))(re.++ (str.to_re (seq.++ "&" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" "")))))))(re.++ (re.+ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (str.to_re (seq.++ "&" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" "")))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
