;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = <img[^>]* src=\"([^\"]*)\"[^>]*>
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "|<img\u00DE src=\"\"g\u00A8>"
(define-fun Witness1 () String (seq.++ "|" (seq.++ "<" (seq.++ "i" (seq.++ "m" (seq.++ "g" (seq.++ "\xde" (seq.++ " " (seq.++ "s" (seq.++ "r" (seq.++ "c" (seq.++ "=" (seq.++ "\x22" (seq.++ "\x22" (seq.++ "g" (seq.++ "\xa8" (seq.++ ">" "")))))))))))))))))
;witness2: "<img\u00D0% src=\"\"i>\u0093oH"
(define-fun Witness2 () String (seq.++ "<" (seq.++ "i" (seq.++ "m" (seq.++ "g" (seq.++ "\xd0" (seq.++ "%" (seq.++ " " (seq.++ "s" (seq.++ "r" (seq.++ "c" (seq.++ "=" (seq.++ "\x22" (seq.++ "\x22" (seq.++ "i" (seq.++ ">" (seq.++ "\x93" (seq.++ "o" (seq.++ "H" "")))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "<" (seq.++ "i" (seq.++ "m" (seq.++ "g" "")))))(re.++ (re.* (re.union (re.range "\x00" "=") (re.range "?" "\xff")))(re.++ (str.to_re (seq.++ " " (seq.++ "s" (seq.++ "r" (seq.++ "c" (seq.++ "=" (seq.++ "\x22" "")))))))(re.++ (re.* (re.union (re.range "\x00" "!") (re.range "#" "\xff")))(re.++ (re.range "\x22" "\x22")(re.++ (re.* (re.union (re.range "\x00" "=") (re.range "?" "\xff"))) (re.range ">" ">")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
