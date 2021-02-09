;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^.*(?:kumar).*$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\\u00E7\x11kumar"
(define-fun Witness1 () String (seq.++ "\x5c" (seq.++ "\xe7" (seq.++ "\x11" (seq.++ "k" (seq.++ "u" (seq.++ "m" (seq.++ "a" (seq.++ "r" "")))))))))
;witness2: "\u00E3`\u00B2\xCS\xCkumar\u00B9"
(define-fun Witness2 () String (seq.++ "\xe3" (seq.++ "`" (seq.++ "\xb2" (seq.++ "\x0c" (seq.++ "S" (seq.++ "\x0c" (seq.++ "k" (seq.++ "u" (seq.++ "m" (seq.++ "a" (seq.++ "r" (seq.++ "\xb9" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (str.to_re (seq.++ "k" (seq.++ "u" (seq.++ "m" (seq.++ "a" (seq.++ "r" ""))))))(re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
