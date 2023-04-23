;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?:mailto:)?(?:[a-z][\w~%!&amp;',;=\-\.$\(\)\*\+]*)@(?:[a-z0-9][\w\-]*[a-z0-9]*\.)*(?:(?:(?:[a-z0-9][\w\-]*[a-z0-9]*)(?:\.[a-z0-9]+)?)|(?:(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)))$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "n7(@er.078.60.240.203"
(define-fun Witness1 () String (str.++ "n" (str.++ "7" (str.++ "(" (str.++ "@" (str.++ "e" (str.++ "r" (str.++ "." (str.++ "0" (str.++ "7" (str.++ "8" (str.++ "." (str.++ "6" (str.++ "0" (str.++ "." (str.++ "2" (str.++ "4" (str.++ "0" (str.++ "." (str.++ "2" (str.++ "0" (str.++ "3" ""))))))))))))))))))))))
;witness2: "p@q"
(define-fun Witness2 () String (str.++ "p" (str.++ "@" (str.++ "q" ""))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (str.to_re (str.++ "m" (str.++ "a" (str.++ "i" (str.++ "l" (str.++ "t" (str.++ "o" (str.++ ":" "")))))))))(re.++ (re.range "a" "z")(re.++ (re.* (re.union (re.range "!" "!")(re.union (re.range "$" ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "~" "~")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))))))))(re.++ (re.range "@" "@")(re.++ (re.* (re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))))(re.++ (re.* (re.union (re.range "0" "9") (re.range "a" "z"))) (re.range "." ".")))))(re.++ (re.union (re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))))(re.++ (re.* (re.union (re.range "0" "9") (re.range "a" "z"))) (re.opt (re.++ (re.range "." ".") (re.+ (re.union (re.range "0" "9") (re.range "a" "z")))))))) (re.++ ((_ re.loop 3 3) (re.++ (re.union (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9"))) (re.++ (re.opt (re.range "0" "1"))(re.++ (re.range "0" "9") (re.opt (re.range "0" "9")))))) (re.range "." "."))) (re.union (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9"))) (re.++ (re.opt (re.range "0" "1"))(re.++ (re.range "0" "9") (re.opt (re.range "0" "9")))))))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
