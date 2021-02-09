;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (.*)-----(BEGIN|END)([^-]*)-----(.*)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "D-----END-----\u00E9\u00CEq\u00C9"
(define-fun Witness1 () String (seq.++ "D" (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ "E" (seq.++ "N" (seq.++ "D" (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ "\xe9" (seq.++ "\xce" (seq.++ "q" (seq.++ "\xc9" "")))))))))))))))))))
;witness2: "-----BEGIN-----"
(define-fun Witness2 () String (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ "B" (seq.++ "E" (seq.++ "G" (seq.++ "I" (seq.++ "N" (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ "-" ""))))))))))))))))

(assert (= regexA (re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (str.to_re (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ "-" ""))))))(re.++ (re.union (str.to_re (seq.++ "B" (seq.++ "E" (seq.++ "G" (seq.++ "I" (seq.++ "N" "")))))) (str.to_re (seq.++ "E" (seq.++ "N" (seq.++ "D" "")))))(re.++ (re.* (re.union (re.range "\x00" ",") (re.range "." "\xff")))(re.++ (str.to_re (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ "-" "")))))) (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
