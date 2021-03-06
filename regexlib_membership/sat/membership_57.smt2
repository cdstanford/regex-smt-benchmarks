;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?:mailto:)?(?:[a-z][\w~%!&amp;',;=\-\.$\(\)\*\+]*)@(?:[a-z0-9][\w\-]*[a-z0-9]*\.)*(?:(?:(?:[a-z0-9][\w\-]*[a-z0-9]*)(?:\.[a-z0-9]+)?)|(?:(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "n7(@er.078.60.240.203"
(define-fun Witness1 () String (seq.++ "n" (seq.++ "7" (seq.++ "(" (seq.++ "@" (seq.++ "e" (seq.++ "r" (seq.++ "." (seq.++ "0" (seq.++ "7" (seq.++ "8" (seq.++ "." (seq.++ "6" (seq.++ "0" (seq.++ "." (seq.++ "2" (seq.++ "4" (seq.++ "0" (seq.++ "." (seq.++ "2" (seq.++ "0" (seq.++ "3" ""))))))))))))))))))))))
;witness2: "p@q"
(define-fun Witness2 () String (seq.++ "p" (seq.++ "@" (seq.++ "q" ""))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (str.to_re (seq.++ "m" (seq.++ "a" (seq.++ "i" (seq.++ "l" (seq.++ "t" (seq.++ "o" (seq.++ ":" "")))))))))(re.++ (re.range "a" "z")(re.++ (re.* (re.union (re.range "!" "!")(re.union (re.range "$" ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "~" "~")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))))))(re.++ (re.range "@" "@")(re.++ (re.* (re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))(re.++ (re.* (re.union (re.range "0" "9") (re.range "a" "z"))) (re.range "." ".")))))(re.++ (re.union (re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))(re.++ (re.* (re.union (re.range "0" "9") (re.range "a" "z"))) (re.opt (re.++ (re.range "." ".") (re.+ (re.union (re.range "0" "9") (re.range "a" "z")))))))) (re.++ ((_ re.loop 3 3) (re.++ (re.union (re.++ (str.to_re (seq.++ "2" (seq.++ "5" ""))) (re.range "0" "5"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9"))) (re.++ (re.opt (re.range "0" "1"))(re.++ (re.range "0" "9") (re.opt (re.range "0" "9")))))) (re.range "." "."))) (re.union (re.++ (str.to_re (seq.++ "2" (seq.++ "5" ""))) (re.range "0" "5"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9"))) (re.++ (re.opt (re.range "0" "1"))(re.++ (re.range "0" "9") (re.opt (re.range "0" "9")))))))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
