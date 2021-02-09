;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^.*(yourdomain.com).*$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "I\u00D3-\u00EB\x17yourdomain,com"
(define-fun Witness1 () String (seq.++ "I" (seq.++ "\xd3" (seq.++ "-" (seq.++ "\xeb" (seq.++ "\x17" (seq.++ "y" (seq.++ "o" (seq.++ "u" (seq.++ "r" (seq.++ "d" (seq.++ "o" (seq.++ "m" (seq.++ "a" (seq.++ "i" (seq.++ "n" (seq.++ "," (seq.++ "c" (seq.++ "o" (seq.++ "m" ""))))))))))))))))))))
;witness2: "x\u00E1\x9yourdomain\u00ECcom"
(define-fun Witness2 () String (seq.++ "x" (seq.++ "\xe1" (seq.++ "\x09" (seq.++ "y" (seq.++ "o" (seq.++ "u" (seq.++ "r" (seq.++ "d" (seq.++ "o" (seq.++ "m" (seq.++ "a" (seq.++ "i" (seq.++ "n" (seq.++ "\xec" (seq.++ "c" (seq.++ "o" (seq.++ "m" ""))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.++ (str.to_re (seq.++ "y" (seq.++ "o" (seq.++ "u" (seq.++ "r" (seq.++ "d" (seq.++ "o" (seq.++ "m" (seq.++ "a" (seq.++ "i" (seq.++ "n" "")))))))))))(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")) (str.to_re (seq.++ "c" (seq.++ "o" (seq.++ "m" ""))))))(re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
