;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[^#]([^ ]+ ){6}[^ ]+$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Yle r \x17\u00CC \u0096\u007F d,\x1B\x13 \u00CF\x6\u00C2 \u00B4\u00D3"
(define-fun Witness1 () String (seq.++ "Y" (seq.++ "l" (seq.++ "e" (seq.++ " " (seq.++ "r" (seq.++ " " (seq.++ "\x17" (seq.++ "\xcc" (seq.++ " " (seq.++ "\x96" (seq.++ "\x7f" (seq.++ " " (seq.++ "d" (seq.++ "," (seq.++ "\x1b" (seq.++ "\x13" (seq.++ " " (seq.++ "\xcf" (seq.++ "\x06" (seq.++ "\xc2" (seq.++ " " (seq.++ "\xb4" (seq.++ "\xd3" ""))))))))))))))))))))))))
;witness2: "\u00D9\u0096 \u00CD \u00AE\u00EE \u007F \u00B77n \u009F \x9"
(define-fun Witness2 () String (seq.++ "\xd9" (seq.++ "\x96" (seq.++ " " (seq.++ "\xcd" (seq.++ " " (seq.++ "\xae" (seq.++ "\xee" (seq.++ " " (seq.++ "\x7f" (seq.++ " " (seq.++ "\xb7" (seq.++ "7" (seq.++ "n" (seq.++ " " (seq.++ "\x9f" (seq.++ " " (seq.++ "\x09" ""))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "\x00" "\x22") (re.range "$" "\xff"))(re.++ ((_ re.loop 6 6) (re.++ (re.+ (re.union (re.range "\x00" "\x1f") (re.range "!" "\xff"))) (re.range " " " ")))(re.++ (re.+ (re.union (re.range "\x00" "\x1f") (re.range "!" "\xff"))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
