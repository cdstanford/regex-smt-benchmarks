;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = <img([^>]*[^/])>
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "o<img\u0083a>"
(define-fun Witness1 () String (seq.++ "o" (seq.++ "<" (seq.++ "i" (seq.++ "m" (seq.++ "g" (seq.++ "\x83" (seq.++ "a" (seq.++ ">" "")))))))))
;witness2: "<img\xF\u00ED\u00BF>\u00C2"
(define-fun Witness2 () String (seq.++ "<" (seq.++ "i" (seq.++ "m" (seq.++ "g" (seq.++ "\x0f" (seq.++ "\xed" (seq.++ "\xbf" (seq.++ ">" (seq.++ "\xc2" ""))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "<" (seq.++ "i" (seq.++ "m" (seq.++ "g" "")))))(re.++ (re.++ (re.* (re.union (re.range "\x00" "=") (re.range "?" "\xff"))) (re.union (re.range "\x00" ".") (re.range "0" "\xff"))) (re.range ">" ">")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
